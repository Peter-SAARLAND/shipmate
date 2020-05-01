FROM registry.gitlab.com/peter.saarland/ansible-boilerplate

ENV SHIPMATE_CARGO_DIR=/cargo
ENV SHIPMATE_SHIPFILE=Shipfile

RUN mkdir -p /shipmate $SHIPMATE_CARGO_DIR

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
  && apt-get update \
  && apt-get install -y --no-install-recommends nodejs \
  && npm install --global semantic-release @semantic-release/gitlab @semantic-release/exec @semantic-release/changelog

WORKDIR /shipmate

COPY . .

WORKDIR $SHIPMATE_CARGO_DIR

ENTRYPOINT ["/shipmate/docker-entrypoint.sh"]