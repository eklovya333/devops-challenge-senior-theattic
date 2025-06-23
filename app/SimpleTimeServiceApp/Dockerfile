FROM node:alpine

WORKDIR /usr/app

COPY . .
RUN npm install
ENV port 3000
EXPOSE 3000
CMD ["npm", "run", "start"]