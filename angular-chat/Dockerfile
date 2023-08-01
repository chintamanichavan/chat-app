# Stage 1
FROM node:14 as node
WORKDIR /usr/src/app
COPY ./ /usr/src/app/
RUN npm install
RUN npm run build --prod

# Stage 2
FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
RUN apt-get update && \
    apt-get install -y curl gnupg2 ca-certificates lsb-release

# Add Nginx's GPG key
RUN curl https://nginx.org/keys/nginx_signing.key | apt-key add -

# To set up the apt repository for stable nginx packages
RUN echo "deb http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" | tee /etc/apt/sources.list.d/nginx.list
RUN echo "deb-src http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" | tee -a /etc/apt/sources.list.d/nginx.list

# Install nginx
RUN apt-get update && \
    apt-get install -y nginx

VOLUME /var/cache/nginx
COPY --from=node /usr/src/app/dist/chat-app /usr/share/nginx/html
COPY ./nginx-custom.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
