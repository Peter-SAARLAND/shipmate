FROM registry.gitlab.com/peter.saarland/ansible-boilerplate

RUN mkdir -p /shipmate /cargo

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
  && apt-get update \
  && apt-get install -y --no-install-recommends nodejs \
  && npm install --global semantic-release @semantic-release/gitlab @semantic-release/exec @semantic-release/changelog

WORKDIR /shipmate

COPY . .

WORKDIR /cargo

ENTRYPOINT ["/shipmate/docker-entrypoint.sh"]