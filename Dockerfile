FROM nginx:1.21

RUN apt-get update && apt-get install unzip -y && apt-get install curl -y

RUN curl -o app.zip -L "http://172.20.10.10:8081/repository/achatfront/achatconfig/front-build/1.0/front-build-1.0.achat.zip" && \
    unzip -o app.zip -d /usr/share/nginx/html && \
    rm app.zip

RUN curl -o nginx.conf -L "http://172.20.10.10:8081/repository/achatfront/achatconfig/nginx-config/1.0/nginx-config-1.0" && \
    mv nginx.conf /etc/nginx/conf.d/nginx.conf

RUN rm /etc/nginx/conf.d/default.conf

RUN apt-get remove -y unzip curl && apt-get autoremove -y

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]