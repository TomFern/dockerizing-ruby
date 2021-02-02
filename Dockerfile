# Dockerfile development version
FROM ruby:2.7.2 AS drkiq-development

# Docker build arguments
ARG USER_ID
ARG GROUP_ID

# Create a user with the same ID and GID
RUN addgroup --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends nodejs yarn

# Default directory
ENV INSTALL_PATH /opt/app
RUN mkdir -p $INSTALL_PATH

# Install gems
WORKDIR $INSTALL_PATH
COPY drkiq/ .
RUN rm -rf node_modules vendor
RUN gem install rails bundler
RUN bundle install
RUN yarn install

# Start server as user
RUN chown -R user:user /opt/app
USER $USER_ID
CMD bundle exec unicorn -c config/unicorn.rb

