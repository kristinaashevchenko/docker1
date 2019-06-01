FROM debian
MAINTAINER Kristina Shevchenko <shnvo@mail.ru>
ADD debian.list /etc/apt/sources.list.d/
RUN apt-get update && \
    apt-get -y upgrade && \
    apt -y install nginx && \
    apt-get clean && \
    rm -rf /var/www/* && \ 
    mkdir -p /var/www/vk.com/img && \
    chmod -R 754 /var/www/vk.com/ && \
    useradd admin && \
    usermod -aG admin admin && \
    chown -R admin:admin /var/www/vk.com/ && \
    sed -i 's/\/var\/www\/html/\/var\/www\/vk.com/g' /etc/nginx/sites-enabled/default && \
    sed -i 's/user www-data/user admin/g' /etc/nginx/nginx.conf
ADD index.html /var/www/vk.com/
ADD img.jpg /var/www/vk.com/img/
CMD ["nginx", "-g", "daemon off;"]
