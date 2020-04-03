FROM makocchi/alpine-git-curl-jq:latest

LABEL "com.github.actions.name"="Push to GitLab (and run GitLab CI)"
LABEL "com.github.actions.description"="Automate pushes a Github Repository to Gitlab"
LABEL "com.github.actions.icon"="git-commit"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/phaus/gitlab-push-action"
LABEL "homepage"="https://github.com/phaus/gitlab-push-action"
LABEL "maintainer"="Philipp Haußleiter <philipp@haussleiter.de>"


COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
