# Setup

## Client Key

```bash
ssh-keygen -f key
cat key.pub
```

Add this public as an deploy Key to your gitlab project.

![gitlab-deploy-key](images/gitlab-deploy-key.png)

```bash
cat key | base64
```

Add this as `SSH_PRIVATE_KEY` variable to your Github project secrets.

## Host Key

Add `GITLAB_HOST` as a variable to retrieve the host key. (e.g. git-lab.de).

## Repository

Add the Gitlab Repository as `GITLAB_REPOSITORY` to your Github project secrets (e.g. `git@git-lab.de:meta-view/homepage.git`).

Use `SRC_BRANCH` to set your Github __source__ branch (e.g. master).  
Use `DST_BRANCH` to set your Gitlab __destination__ branch (e.g. master).


## Build Setup

```yaml
name: Push to Gitlab

on:
  push:
    branches: [ master ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - name: Push to Gitlab
      uses: phaus/gitlab-push-action@master
      with:
        args: "https://gitlab.com/<namespace>/<repository>"
      env:
        GITLAB_HOST: "git-lab.de"
        GITLAB_REPOSITORY: "git@git-lab.de:meta-view/homepage.git"
        SSH_PRIVATE_KEY: ${{ secrets.SSH_PRIVATE_KEY }}
        SRC_BRANCH: "master"
        DST_BRANCH: "master"
```
