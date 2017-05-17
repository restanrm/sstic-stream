from debian:latest

RUN apt-get update && apt-get install -y \
  build-essential libpcre3 libpcre3-dev libssl-dev unzip wget && \
  apt-get clean


RUN cd /tmp && \
  wget http://nginx.org/download/nginx-1.12.0.tar.gz && \
  wget https://github.com/arut/nginx-rtmp-module/archive/master.zip && \
  tar xzvf nginx-1.12.0.tar.gz && \
  unzip master.zip && \
  cd nginx-1.12.0 && \
  ./configure --add-module=../nginx-rtmp-module-master --with-http_ssl_module && \
  make && make install && \
  mkdir -p /var/www/stat /var/www/hls /var/www/player && \
  cp ../nginx-rtmp-module-master/stat.xsl /var/www/stat/ && \
  cd - && \
  wget https://static.sstic.org/streaming2017/player.tar.gz && \
  tar xzvf player.tar.gz -C /var/www/player && \
  rm -fr /tmp/* 

#ADD https://godist.herokuapp.com/projects/ddollar/forego/releases/current/linux-amd64/forego /usr/local/bin/forego
ADD https://bin.equinox.io/c/ekMN3bCZFUn/forego-stable-linux-amd64.tgz /tmp/forego.tgz
COPY Procfile /Procfile
COPY entrypoint.sh /entrypoint.sh
RUN tar -xzvf /tmp/forego.tgz -C /usr/local/bin/ && \
    rm /tmp/forego.tgz && \
    chmod +x /entrypoint.sh && \
    chmod +x /usr/local/bin/forego
COPY nginx.conf /usr/local/nginx/conf/nginx.conf

EXPOSE 80 1935

ENTRYPOINT ["/entrypoint.sh"]
