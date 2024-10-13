FROM mariadb:10.6

RUN apt update
RUN apt install -y inetutils-ping

ENTRYPOINT []
