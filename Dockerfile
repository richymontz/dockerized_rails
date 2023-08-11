# Dockerfile development version
FROM ruby:3.1.2 AS dockerized-rails-development

# Default directory
ENV INSTALL_PATH /opt/app
RUN mkdir -p $INSTALL_PATH

# Install gems
WORKDIR $INSTALL_PATH
COPY dockerized_rails/ .
RUN rm -rf node_modules vendor
RUN gem install rails bundler
RUN bundle install

# Start server
CMD bundle exec unicorn -c config/unicorn.rb