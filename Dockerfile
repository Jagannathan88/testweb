# Use the nginx base image with Alpine Linux
FROM nginx:alpine

# Remove any existing content in the default nginx html directory
RUN rm -rf /usr/share/nginx/html/*

# Copy the entire content of the current directory into the nginx html directory
COPY . /usr/share/nginx/html

# Expose port 80 to allow outside access to the container
EXPOSE 80

