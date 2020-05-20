ARG DOCKER_BASE_IMAGE
FROM ${DOCKER_BASE_IMAGE:-registry.gitlab.com/peter.saarland/ansible-boilerplate:latest}
LABEL maintainer="Fabian Peter <fabian@peter.saarland>"

ENV SHIPMATE_CARGO_DIR=/cargo
ENV SHIPMATE_SHIPFILE=Shipfile
ENV ENVIRONMENT_DIR=/root/.if0/.environments/zero
ENV ANSIBLE_STRATEGY=free

RUN mkdir -p ${ENVIRONMENT_DIR} /shipmate $SHIPMATE_CARGO_DIR /root/.ssh

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
  && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
  && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
  && apt-get update \
  && apt-get install -y --no-install-recommends nodejs docker-ce docker-ce-cli containerd.io \
  && npm install --global semantic-release @semantic-release/gitlab @semantic-release/exec @semantic-release/changelog


WORKDIR /shipmate

COPY . .

RUN echo 'export PS1="[\$IF0_ENVIRONMENT] \W # "' >> /root/.bashrc

ENTRYPOINT ["/shipmate/docker-entrypoint.sh"]

CMD ["/bin/bash"]