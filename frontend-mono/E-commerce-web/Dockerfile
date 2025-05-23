# Builder
FROM node:18 as build
WORKDIR /app
COPY . .
RUN npm install && npm run build -- --project=E-commerce-web --configuration production

# NGINX
FROM nginx:alpine
COPY --from=build /app/dist/e-commerce-web/browser /usr/share/nginx/html

COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
