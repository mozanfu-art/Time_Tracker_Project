# Use a lightweight web server
FROM nginx:alpine

# Copy Flutter web build output into Nginx's default html folder
COPY build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Run Nginx
CMD ["nginx", "-g", "daemon off;"]