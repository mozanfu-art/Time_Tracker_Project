# Use Flutter SDK image to build
FROM cirrusci/flutter:stable AS build

WORKDIR /app
COPY . .
RUN flutter build web

# Use Nginx to serve
FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]