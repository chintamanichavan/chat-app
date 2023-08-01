# Stage 1 - Angular Build
FROM node:14 as angular-build
WORKDIR /usr/src/app
COPY ./angular-chat/ /usr/src/app/  # Using 'angular-chat' directory
RUN npm install
RUN npm run build --prod

# Stage 2 - Django Setup
FROM python:3.9 as django-build
WORKDIR /code
COPY ./django_chat/requirements.txt /code/ # Using 'django_chat' directory
RUN pip install -r requirements.txt
COPY ./django_chat /code/

# Stage 3 - Nginx server for Angular static files
FROM nginx:ubuntu
COPY --from=angular-build /usr/src/app/dist/angular-chat /usr/share/nginx/html  # Assuming Angular app is building into 'angular-chat' directory
COPY ./django_chat/nginx-custom.conf /etc/nginx/conf.d/default.conf  # Assuming 'nginx-custom.conf' is in 'django_chat' directory
VOLUME /var/cache/nginx
