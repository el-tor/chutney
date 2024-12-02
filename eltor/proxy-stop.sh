#!/bin/bash

pkill -f eltor
pkill -f haproxy

# Kill process on specific ports
lsof -ti :9098 | xargs kill -9
lsof -ti :8852 | xargs kill -9
lsof -ti :4747 | xargs kill -9