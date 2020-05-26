# Shipmate Development Workflow

**Shipmate** aims to be simple and thus implements a very simple **Development Workflow**. **Shipmate** is designed on top of [GitLab CI](https://about.gitlab.com) and currently doesn't natively support GitHub or other Source Code Repository Providers.

- **Shipmate** runs on **Merge Requests** and multiple **Release Branches**
  - Stable Releases:
    - `master`
  - Pre-Releases
    - `beta`
    - `alpha`
  - Maintenance Releases
    - `"+([0-9])?(.{+([0-9]),x}).x"` (e.g. 1.0.x)
- **Shipmate** DOESN'T run on **Feature Branches**
- **Shipmate** works in 3 stages that seemlessly map to **GitLab CI Stages**:
  - `tag`: in this stage, **Shipmate** generates the version for the current project. If running for a **Merge Request**, the version will be generated out of **Commit SHA** and **Branch Name** (e.g. `v28sh7hd820-fix/bug-id`). If running for a **Release Branch**, the version will be computed from the project's [Releases](https://docs.gitlab.com/ee/user/project/releases/)
  - `build`: in this stage, **Shipmate** builds artifacts (e.g. Docker Images) for the current project. It auto-discovers many [Shipping Providers](shipping-providers.md) to build for out of the box.
  - `ship`: in this stage, **Shipmate** ships your artifacts (e.g. Docker Images) to the relevant platforms (e.g. **GitLab Container Registry**, **Ansible Galaxy**, **Debian Repositories**, and more).

The **Shipmate Development Workflow** looks like this:

1. Use [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) for **ALL** Commit Messages
2. Develop in **Feature Branches** (e.g. `feat/new-tooling-23` or `10-integrate-new-app-packaging`)
3. Create [Merge Requests](https://docs.gitlab.com/ee/user/project/merge_requests/) to merge your code to your **Release Branches**
4. Only merge code that doesn't break
5. Enjoy automated software logistics for each push to a **Feature Branch** or **Release Branch**
