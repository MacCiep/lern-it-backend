# Use an official Ruby runtime as a parent image
FROM ruby:3.1.2

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Install the RoR application
COPY . .
RUN bundle install
EXPOSE $BACKEND_EXTERNAL_PORT

# Setup and run the application
RUN chmod +x ./docker-entrypoint.sh
ENTRYPOINT ["./docker-entrypoint.sh"]
