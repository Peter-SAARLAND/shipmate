# Get Started

**shipmate** - automate your software logistics

## About

**shipmate** is a tool to automate chores around software releases. 

- automated semantic versioning with [semantic-release](https://github.com/semantic-release/semantic-release)
- automated Docker builds
- tightly integrated with GitLab

## Use it

**It's simple!** Just include the following code in your repository's `.gitlab-ci-yml`:

```
include:
  - remote: "https://gitlab.com/peter.saarland/scratch/-/raw/master/ci/templates/shipmate.gitlab-ci.yml"
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