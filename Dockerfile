FROM debian
MAINTAINER Kristina Shevchenko <shnvo@mail.ru>
ADD debian.list /etc/apt/sources.list.d/ 
RUN apt-get update && \       #обновлениекэша
    apt-get -y upgrade && \    #обновлениевсехпакетов
    apt -y install nginx && \   #установкавебсервера
    apt-get clean && \           #очисткакэша
    rm -rf /var/www/* && \       #удалениесодержимогодериктории
    mkdir -p /var/www/vk.com/img && \     #созданиепапкискартинками
    chmod -R 754 /var/www/vk.com/ && \    #укогокакойдоступ
    useradd admin && \                  #созданиепользователяимя
    usermod -aG admin admin && \        #переещениепользователя
    chown -R admin:admin /var/www/vk.com/ && \ 
    sed -i 's/\/var\/www\/html/\/var\/www\/vk.com/g' /etc/nginx/sites-enabled/default && \    #замена
    sed -i 's/user www-data/user admin/g' /etc/nginx/nginx.conf     #замена
ADD index.html /var/www/vk.com/       #загружаемвфайл
ADD img.jpg /var/www/vk.com/img/      #загружаемвфайл
CMD ["nginx", "-g", "daemon off;"] #запускнахостмашине
