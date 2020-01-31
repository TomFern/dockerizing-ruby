# Dockerfile development version
# Intended to use volumes to map code

FROM ruby:2.7 AS drkiq-development
MAINTAINER SemaphoreCI

# Docker build arguments
ARG USER_ID
ARG GROUP_ID

# Create a user with the same ID and GID
RUN addgroup --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user

# Default directory
ENV INSTALL_PATH /opt/app
RUN mkdir -p $INSTALL_PATH

# Install rails
RUN gem install rails bundler

# Install gems
COPY drkiq/Gemfile Gemfile
WORKDIR /opt/app/drkiq
RUN bundle install

# Start server as user
RUN chown -R user:user /opt/app
USER $USER_ID
VOLUME ["$INSTALL_PATH/public"]
CMD bundle exec unicorn -c config/unicorn.rb

