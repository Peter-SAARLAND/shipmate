# Shipping Providers

Out of the box, **Shipmate** can discover a range of providers your software can be packaged for and shipped to:

- [GitLab Releases](https://docs.gitlab.com/ee/user/project/releases/)
- [GitLab Container Registry](https://docs.gitlab.com/ee/user/packages/container_registry/)
- [Ansible Galaxy](https://galaxy.ansible.com/)
- Docker
- NuGet (TBA)
- Pip (TBA)

## Docker

If **Shipmate** finds a `Dockerfile` in the root directory of your code repository, it will try to build and tag it.

- `tag`: generate $VERSION for image (e.g. `v1.6.3`)
- `build`: build docker image and push to registry with $VERSION from `tag` stage (e.g. `registry.gitlab.com/group/project/branch:v1.6.3`)
- `ship`: ship docker image from `build` stage as `latest` and `v$VERSION` to docker registry (e.g. `registry.gitlab.com/group/project:latest`)
