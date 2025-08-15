# Use official Ruby image
FROM ruby:3.2.2

# Set environment variables
ENV RAILS_ENV=development \
    NODE_VERSION=20xw

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    postgresql-client \
    nodejs \
    npm \
    yarn \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Install bundler
RUN gem install bundler

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the rest of the app
COPY . .

# Copy entrypoint script
COPY entrypoint.sh /usr/bin/
ENTRYPOINT ["entrypoint.sh"]

# Expose port
EXPOSE 3000

# Start Rails server
CMD ["bin/rails", "server", "-b", "0.0.0.0"]