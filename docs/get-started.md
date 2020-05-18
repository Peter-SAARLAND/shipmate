# Get Started

## Install Ansible

### MacOS

```
brew install ansible
```

## Install Ansible Dependencies

```
requirements.yml
```

## Install NodeJS

### MacOS

```
brew install node@14
```

## Install semantic-release

```
npm install @semantic-release/gitlab @semantic-release/exec @semantic-release/changelog
```

## Use in CI

### GitLab CI

Edit `.gitlab-ci.yml` and include shipmate's release-stage.

**Note:** This only works if you're using **shipmate**'s [Development Workflow](development-workflow.md). It's easy! Try it yourself.

```bash
include:
  - remote: 'https://gitlab.com/peter.saarland/scratch/-/raw/master/ci/templates/shipmate/release.gitlab-ci.yml'
```

```bash
docker run -ti -v "${HOME}/.ssh:/root/.ssh" -v "${PWD}:/cargo" shipmate ansible-playbook /shipmate/playbooks/ahoi.yml
```