FROM registry.gitlab.com/peter.saarland/ansible-boilerplate

RUN mkdir -p /ship

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
  && apt-get update \
  && apt-get install -y --no-install-recommends nodejs \
  && npm install semantic-release @semantic-release/gitlab @semantic-release/exec @semantic-release/changelog

COPY docker-entrypoint.sh /docker-entrypoint.sh

WORKDIR /ship

ENTRYPOINT ["/docker-entrypoint.sh"]