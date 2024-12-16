import socket
import os

def read_cookie(cookie_path):
    """
    Reads the control_auth_cookie file and returns its content as a hex string.
    """
    with open(cookie_path, "rb") as f:
        return f.read().hex()

def send_command(connection, command):
    """
    Sends a raw command to the Tor control connection.
    """
    connection.sendall((command + "\n").encode("utf-8"))

def parse_event(event):
    """
    Parses an event line and extracts the event type and data.

    Args:
        event (str): The raw event string.

    Returns:
        dict: Parsed event details including type and data.
    """
    parts = event.split(maxsplit=2)
    if len(parts) < 3:
        return {"error": "Invalid event format"}

    event_code, event_type, event_data = parts
    return {
        "code": event_code,
        "type": event_type,
        "data": event_data,
    }

def listen_for_events(connection):
    """
    Continuously listens for events from the Tor control port.
    """
    try:
        while True:
            # Read data from the control connection
            data = connection.recv(4096).decode("utf-8").strip()
            if data:
                parsed_event = parse_event(data)
                if "error" in parsed_event:
                    print(f"Error parsing event: {parsed_event['error']}")
                else:
                    print(f"Event Code: {parsed_event['code']}")
                    print(f"Event Type: {parsed_event['type']}")
                    print(f"Event Data: {parsed_event['data']}")
    except KeyboardInterrupt:
        print("Stopping event listener.")
    except Exception as e:
        print(f"Error while listening for events: {e}")

def keep_connection_alive():
    """
    Maintains a persistent raw RPC connection to the Tor control port.
    """
    tor_control_port = ("127.0.0.1", 8055)
    # Use the home directory to dynamically resolve the cookie path
    cookie_path = os.path.expanduser("~/code/chutney/net/nodes/000a/control_auth_cookie")

    try:
        # Read the cookie for authentication
        cookie = read_cookie(cookie_path)

        # Connect to the Tor control port
        connection = socket.create_connection(tor_control_port)

        # Authenticate with the control port
        send_command(connection, f"AUTHENTICATE {cookie}")
        auth_response = connection.recv(4096).decode("utf-8").strip()
        if "250 OK" not in auth_response:
            print(f"Authentication failed: {auth_response}")
            return
        print("Authenticated with Tor control port.")

        # Subscribe to events
        send_command(connection, "SETEVENTS PAYMENT_ID_HASH_RECEIVED")
        print("Subscribed to PAYMENT_ID_HASH_RECEIVED.")

        # Listen for events
        print("Listening for events. Press Ctrl+C to stop.")
        listen_for_events(connection)
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    keep_connection_alive()
