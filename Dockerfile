FROM nginx

USER 0

WORKDIR 
COPY . .
RUN yum install -y npm
RUN npm install \
 && npm run start
COPY .nginx.conf /etc/nginx/nginx.conf
CMD ["nginx", "-g", "daemon-off"]