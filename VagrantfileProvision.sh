#!/bin/sh

# Set language and locale
apt-get install -y language-pack-en
locale-gen --purge en_US.UTF-8
echo "LC_ALL='en_US.UTF-8'" >> /etc/environment
dpkg-reconfigure locales

# Erlang repo
echo "deb http://packages.erlang-solutions.com/ubuntu xenial contrib" >> /etc/apt/sources.list && \
apt-key adv --fetch-keys http://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc

# Postgres repo
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | apt-key add -

# Node repo
echo 'deb https://deb.nodesource.com/node_6.x xenial main' > /etc/apt/sources.list.d/nodesource.list
wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -

apt-get -qq update

# Install packages
apt-get install -y \
wget \
git \
unzip \
build-essential \
ntp \
inotify-tools \
esl-erlang \
elixir \
postgresql-9.5 \
postgresql-contrib-9.5 \
nodejs \
imagemagick

PG_CONF="/etc/postgresql/9.5/main/postgresql.conf"
echo "client_encoding = utf8" >> "$PG_CONF" # Set client encoding to UTF8
service postgresql restart

cat << EOF | su - postgres -c psql
ALTER USER postgres WITH ENCRYPTED PASSWORD 'postgres';
EOF
