import base64
import sys

# Check if a Base64 string was passed as an argument
if len(sys.argv) != 2:
    print("Usage: python script.py <base64_string>")
    sys.exit(1)

# Read the Base64 string from the command line
base64_string = sys.argv[1]

# Add padding if necessary (Base64 strings must be divisible by 4)
# Base64 strings should have a length that is a multiple of 4, otherwise padding ('=') is needed.
missing_padding = len(base64_string) % 4
if missing_padding != 0:
    base64_string += '=' * (4 - missing_padding)

try:
    # Decode the Base64 string to bytes
    decoded_bytes = base64.b64decode(base64_string)

    # Convert the bytes to a hex string
    hex_string = decoded_bytes.hex()

    # Print the hex string in uppercase (Tor fingerprints are typically uppercase)
    print(hex_string.upper())

except Exception as e:
    print(f"Error decoding Base64 string: {e}")