sudo -s
apt-get update
apt-get install docker.io
systemctl start docker
systemctl enable docker
docker pull mariadb

mkdir ~/wordpress
mkdir -p ~/wordpress/database
mkdir -p ~/wordpress/html



docker run -e MYSQL_ROOT_PASSWORD=aqwe123 -e MYSQL_USER=wpuser -e MYSQL_PASSWORD=wpuser@ -e MYSQL_DATABASE=wordpress_db -v /root/wordpress/database:/var/lib/mysql --name wordpressdb -d mariadb


docker inspect -f '{{ .NetworkSettings.IPAddress }}' wordpressdb



mysql -u wpuser -h 172.17.0.2 -p 
TYPE PASSWORD: wpuser@


docker run -e WORDPRESS_DB_USER=wpuser -e WORDPRESS_DB_PASSWORD=wpuser@ -e WORDPRESS_DB_NAME=wordpress_db -p 8081:80 -v /root/wordpress/html:/var/www/html --link wordpressdb:mysql --name wpcontainer -d wordpress


apt-get install nginx


cd /etc/nginx/sites-available/
vim wordpress


server {
  listen 80;
  server_name wordpress-docker.co www.wordpress-docker.co;
 
  location / {
    proxy_pass http://localhost:8081;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  }
}



ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-available/default
rm -f /etc/nginx/sites-enabled/default


systemctl restart nginx





start datadog AGENT
docker run -d --name dd-agent \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  -v /proc/:/host/proc/:ro \
  -v /sys/fs/cgroup/:/host/sys/fs/cgroup:ro \
  -e API_KEY={your_api_key_here} \
  -e SD_BACKEND=docker \
  -e NON_LOCAL_TRAFFIC=false \
  datadog/docker-dd-agent:latest
datadog API_KEY 2c7c9613826cf2a0049a1ebf1e6fdb87
