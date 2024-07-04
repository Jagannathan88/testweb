# Use the official Nginx image as the base image
FROM nginx:alpine

# Copy the build output to the Nginx html directory
COPY build/ /usr/share/nginx/html

# Expose port 80
EXPOSE 80
