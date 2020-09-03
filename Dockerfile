ARG DOCKER_BASE_IMAGE
FROM ${DOCKER_BASE_IMAGE:-registry.gitlab.com/peter.saarland/ansible-boilerplate:latest}
LABEL maintainer="Fabian Peter <fabian@peter.saarland>"

ARG DOCKER_IMAGE
ARG SHIPMATE_AUTHOR_URL
ARG SHIPMATE_AUTHOR
ARG SHIPMATE_BUILD_DATE
ARG SHIPMATE_CARGO_VERSION
ARG SHIPMATE_COMMIT_ID
ARG THIS_VERSION

LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date="$SHIPMATE_BUILD_DATE"
LABEL org.label-schema.name="$DOCKER_IMAGE"
LABEL org.label-schema.vendor="$SHIPMATE_AUTHOR"
LABEL org.label-schema.url="$SHIPMATE_AUTHOR_URL"
LABEL org.label-schema.version="$SHIPMATE_CARGO_VERSION"
LABEL org.label-schema.vcs-ref="$SHIPMATE_COMMIT_ID"

ENV SHIPMATE_CARGO_DIR=/cargo
ENV THIS_VERSION=${THIS_VERSION}
ENV ANSIBLE_STRATEGY=linear

RUN mkdir -p /shipmate $SHIPMATE_CARGO_DIR /root/.ssh

RUN  apt-get update  \
  && apt-get install -y --no-install-recommends software-properties-common \
  && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
  && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
  && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
  && apt-get update \
  && apt-get install -y --no-install-recommends nodejs docker-ce-cli \
  && npm install --global semantic-release @semantic-release/gitlab @semantic-release/exec @semantic-release/changelog

WORKDIR /shipmate

COPY . .

RUN echo 'export PS1="[\$IF0_ENVIRONMENT] \W # "' >> /root/.bashrc \
    && echo "$THIS_VERSION" > /shipmate/VERSION.txt

WORKDIR /cargo

ENTRYPOINT ["/shipmate/docker-entrypoint.sh"]

CMD ["/bin/bash"]