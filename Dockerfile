# Используем Ruby 3.3.1 образ
FROM ruby:3.3.1-slim

# Устанавливаем зависимости
RUN apt-get update -qq && apt-get install -y \
  build-essential libpq-dev nodejs sqlite3 tzdata

# Создаем директорию для приложения
WORKDIR /app

# Копируем Gemfile и Gemfile.lock для установки зависимостей
COPY Gemfile Gemfile.lock ./

# Устанавливаем зависимости
RUN bundle install

# Копируем исходный код приложения
COPY . .

# Открываем порт 80
EXPOSE 80

# Компилируем ассеты (если используются)
RUN bundle exec rails assets:precompile

# Запускаем сервер Puma
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
