FROM nginx

USER 0
COPY ./nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /var/log/nginx && touch /var/log/nginx/access.log /var/log/nginx/error.log && chmod -R 755 /var/log/nginx && chown -R nginx:nginx /var/log/nginx
CMD ["nginx", "-g", "daemon off;"]