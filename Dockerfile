FROM nginx:latest
WORKDIR /var/www/html
RUN chmod -R 777 /var 
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /var/www/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
