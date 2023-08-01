# Stage 1 - Angular Build

# ---- Base Node ----
FROM ubuntu:20.04 AS build-stage   

WORKDIR /usr/src/app

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y curl gnupg2 ca-certificates lsb-release nodejs npm

COPY ./angular-chat/ /usr/src/app/

RUN npm install
RUN npm run build --prod

# Stage 2 - Django Build
# ---- Base Python ----
FROM python:3.9

ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code

# ---- Copy Files/Build ----
# Copy the Django static files from the build-stage
COPY --from=build-stage /usr/src/app/dist/chat-app /usr/share/nginx/html

# Copy the Django requirements and install them
COPY ./django_chat/requirements.txt /code/
RUN pip install -r requirements.txt

# Copy the rest of the Django application
COPY ./django_chat/ /code/

# Stage 3 - Nginx server for Angular static files
FROM nginx:ubuntu
COPY --from=angular-build /usr/src/app/dist/angular-chat /usr/share/nginx/html  # Assuming Angular app is building into 'angular-chat' directory
COPY ./django_chat/nginx-custom.conf /etc/nginx/conf.d/default.conf  # Assuming 'nginx-custom.conf' is in 'django_chat' directory
VOLUME /var/cache/nginx
