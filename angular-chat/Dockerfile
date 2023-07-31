# Stage 1
FROM node:14 as node
WORKDIR /usr/src/app
COPY ./ /usr/src/app/
RUN npm install
RUN npm run build --prod

# Stage 2
FROM nginx:alpine
VOLUME /var/cache/nginx
COPY --from=node /usr/src/app/dist/chat-app /usr/share/nginx/html
COPY ./nginx-custom.conf /etc/nginx/conf.d/default.conf
