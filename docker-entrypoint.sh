#!/bin/bash

# This script is executed when the container is started
set -e

# Remove a potentially pre-existing server.pid for Rails to avoid conflicts
rm -f tmp/pids/server.pid

# Setup database - trigger migrations if needed
bundle exec rails db:prepare

# Start the Rails server - bind to all interfaces
bundle exec rails s -p "$BACKEND_EXTERNAL_PORT" -b '0.0.0.0'
#Execute the command passed to the container
#exec "$@"

exit 0