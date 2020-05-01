FROM registry.gitlab.com/peter.saarland/ansible-boilerplate
COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]