# Use the Flutter web build image
FROM cirrusci/flutter:stable as build

# Set the working directory
WORKDIR /app

# Copy the Flutter project
COPY . .

# Run Flutter build for web
RUN flutter build web

# Use a lightweight web server to serve the built files
FROM nginx:alpine

# Copy the built files to the nginx HTML directory
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose the port nginx will serve on
EXPOSE 80

# Start nginx server
CMD ["nginx", "-g", "daemon off;"]
