FROM ruby:2.7 AS rails-toolbox
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
# RUN apt-get update && apt-get install --no-install-recommends -y rails bundler
RUN gem install rails bundler
RUN chown user:user /opt/app
WORKDIR /opt/app

# Run a shell as the user
USER $USER_ID
CMD ["/bin/sh"]

# Install dependencies:
#   - build-essential: To ensure certain gems can be compiled
#   - nodejs: Compile assets
#   - libpq-dev: Communicate with postgres through the postgres gem
#   - postgresql-client-9.4: In case you want to talk directly to postgres
# RUN apt-get update && apt-get install -qq -y build-essential nodejs libpq-dev postgresql-client-9.4 --fix-missing --no-install-recommends

# Set an environment variable to store where the app is installed to inside
# of the Docker image.
# ENV INSTALL_PATH /opt/app/drkiq
# RUN mkdir -p $INSTALL_PATH



# # This sets the context of where commands will be ran in and is documented
# # on Docker's website extensively.
# WORKDIR $INSTALL_PATH

# # Ensure gems are cached and only get updated when they change. This will
# # drastically increase build times when your gems do not change.
# COPY drkiq/Gemfile Gemfile
# RUN bundle install

# # Copy in the application code from your work station at the current directory
# # over to the working directory.
# COPY drkiq/ .
# COPY start-drkiq.sh .

# # Provide dummy data to Rails so it can pre-compile assets.
# # RUN bundle exec rake RAILS_ENV=development DATABASE_URL=postgresql://drkiq:yourpassword@127.0.0.1/dbname SECRET_TOKEN=pickasecuretoken assets:precompile

# # Expose a volume so that nginx will be able to read in assets in production.
# VOLUME ["$INSTALL_PATH/public"]

# # The default command that gets ran will be to start the Unicorn server.
# CMD bundle exec unicorn -c config/unicorn.rb
# # CMD ["./start-drkiq.sh"]
# # CMD ["pwd"]
