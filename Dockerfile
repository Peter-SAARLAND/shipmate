FROM registry.gitlab.com/peter.saarland/ansible-boilerplate:latest

ENV SHIPMATE_CARGO_DIR=/cargo
ENV SHIPMATE_SHIPFILE=Shipfile
ENV ENVIRONMENT_DIR=/root/.if0/.environments/zero

RUN mkdir -p ${ENVIRONMENT_DIR} /shipmate $SHIPMATE_CARGO_DIR /root/.ssh

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
  && apt-get update \
  && apt-get install -y --no-install-recommends nodejs \
  && npm install --global semantic-release @semantic-release/gitlab @semantic-release/exec @semantic-release/changelog

WORKDIR /shipmate

COPY . .

RUN echo 'export PS1="[\$IF0_ENVIRONMENT] \W # "' >> /root/.bashrc

ENTRYPOINT ["/shipmate/docker-entrypoint.sh"]

CMD ["/bin/bash"]