# Shipmate - advanced software logistics

**shipmate** - automate your software logistics

## About

**shipmate** is a tool to automate chores around software releases. By enabling **Shipmate** for your repository, you gain the following features without further ado:

- automated semantic versioning and releases with [semantic-release](https://github.com/semantic-release/semantic-release)
- automated changelog based on your [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)
- automated Docker builds and releases (GitLab Container Registry)
- tightly integrated with GitLab (GitLab Registry, Merge Requests, ...)

**Shipmate** aims to be a friendly replacement for **GitLab Auto DevOps** which - in our opinion - is focused too tighlty on Kubernetes and not yet suitable for more generalistic use-cases.

It was designed to automate the software release process in a systemized and generalistic approach. **Shipmate** helps to **tag**, **build** and **ship** your software to:

- [GitLab Releases](https://docs.gitlab.com/ee/user/project/releases/)
- [GitLab Container Registry](https://docs.gitlab.com/ee/user/packages/container_registry/)
- [Ansible Galaxy](https://galaxy.ansible.com/)
- [and more](shipping-providers.md)

## Use it

**It's simple!**

### 1. Enable Shipmate for GitLab CI

Include the following code in your repository's `.gitlab-ci-yml`:

```bash
include:
  - remote: "https://gitlab.com/peter.saarland/scratch/-/raw/master/ci/templates/shipmate.gitlab-ci.yml"
```

> You can still use your own stages, jobs and CI config. Please review **Shipmate's** [CI Config](https://gitlab.com/peter.saarland/scratch/-/raw/master/ci/templates/shipmate.gitlab-ci.yml) and [GitLab Pipeline Config](https://docs.gitlab.com/ee/ci/yaml/) for advanced usage.

### 2. Populate GitLab Personal Access Token

Setup a [Personal Access Token](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html) and add it as `GL_TOKEN` to the [GitLab CI Variables](https://docs.gitlab.com/ee/ci/variables/) of your **project** or **group**.

![GitLab CI Variables](gitlab-ci-vars.png)

### 3. Commit & Push

**Shipmate** automates the versioning of your code based on your commit messages. To be able to compute a version number out of your commit messages and previous releases, commits need to follow a certain convention - namely [Conventional Commits v1.0.0](https://www.conventionalcommits.org/en/v1.0.0/).

Now everytime you create a **Merge Request** or push to a **Release Branch**, **Shipmate** takes care of **Versioning** and **Releases** for your software.

## What you get

**Shipmate** automatically discovers a range of [Shipping Providers](shipping-providers.md) automatically and handles packaging and shipping according to industry best-practices.

## Configuration

By default, **Shipmate** doesn't need much configuration. You can configure lots of things through **Environment Variables** though:

```TBD```

**Shipmate** aims to be simple and thus doesn't implement much of its own configuration. The toolchain chosen for **Shipmate** is aligned with the standards of the [12 Factor App](https://12factor.net/) methodology and the [CNCF](https://www.cncf.io/) and its projects to be very flexible and seemless to use. Thus, most of the configuration options are directly derived from the tools in use:

- [semantic-release](https://github.com/semantic-release/semantic-release)
- [Ansible](https://docs.ansible.com/ansible/latest/reference_appendices/config.html)
- [GitLab CI](https://docs.gitlab.com/ee/ci/variables/)

This software is developed on GitLab and mirrored to GitHub.

## Related Links

- [lake0](https://gitlab.com/peter.saarland/lake0/) - Container-native Backups
- [ns0](https://gitlab.com/peter.saarland/ns0/) - The container-native DNS Proxy
- [shipmate](https://gitlab.com/peter.saarland/shipmate/) - Release Distribution Automation
- [shopware](https://gitlab.com/peter.saarland/shopware/) - Shopware 5 in Docker
- [apollo](https://gitlab.com/p3r.one/apollo/) - Platform as a Service toolkit

## Contact

- [Slack](https://join.slack.com/t/petersaarland/shared_invite/zt-d9ao21f9-pb70o46~82P~gxDTNy_JWw)
- [LinkedIn](https://www.linkedin.com/in/fabian-peter-7b3466122/)
- [XING](https://www.xing.com/profile/Fabian_Peter4/cv)
- [GitLab](https://gitlab.com/peter.saarland)
- [GitHub](https://github.com/Peter-SAARLAND/)
- [Matrix](https://matrix.to/#/!RcYHgbzWjyNTYeEIZj:hello.peter.saarland?via=hello.peter.saarland)

## Documentation

- [Get Started](docs/get-started.md)
