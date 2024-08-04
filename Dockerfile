# Use uma imagem base do Ruby
FROM ruby:3.3.4

# Instale dependências do sistema
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  curl \
  cron \
  build-essential \
  libsqlite3-dev

# Instale a gem 'whenever' globalmente
RUN gem install whenever

# Defina o diretório de trabalho
WORKDIR /myapp

# Copie o Gemfile e o Gemfile.lock para o contêiner
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# Instale as gems
RUN bundle install

# Copie o restante do código da aplicação para o contêiner
COPY . /myapp

# Configure o banco de dados
RUN rails db:setup

# Adicione o cron job
RUN bundle exec whenever --update-crontab

# Exponha a porta padrão
EXPOSE 3000

# Comando para iniciar o servidor e o cron
CMD ["sh", "-c", "cron && rails server -b 0.0.0.0"]
