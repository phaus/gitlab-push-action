FROM alpine:3.11

LABEL "com.github.actions.name"="Push to GitLab (and run GitLab CI)"
LABEL "com.github.actions.description"="Automate pushes a Github Repository to Gitlab"
LABEL "com.github.actions.icon"="git-commit"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/phaus/gitlab-push-action"
LABEL "homepage"="https://github.com/phaus/gitlab-push-action"
LABEL "maintainer"="Philipp Haußleiter <philipp@haussleiter.de>"

RUN apk add --update git openssh bash git-lfs && \
    rm -rf /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
