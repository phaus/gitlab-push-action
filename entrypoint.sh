#!/bin/sh

set -u -e -x

# fix see https://stackoverflow.com/a/18079668
rm -f /dev/tty
mknod -m 666 /dev/tty c 5 0

echo "Push $GITHUB_REPOSITORY to $GITLAB_REPOSITORY"
mkdir -p ~/.ssh
echo ${SSH_PRIVATE_KEY} | base64 -d > ~/.ssh/id_rsa

chmod go-w ~/
chmod 700 ~/.ssh
chmod 0600 ~/.ssh/id_rsa

ssh -o StrictHostKeyChecking=no -v "git@${GITLAB_HOST}"

cat ~/.ssh/id_rsa
ls -al ~/.ssh

git checkout "${GITHUB_REF:11}"
git-lfs install 

git remote add gitlab $GITLAB_REPOSITORY
git push gitlab $SRC_BRANCH:$DST_BRANCH

echo "Git Version $(git describe --always --dirty --tags):"
git status
