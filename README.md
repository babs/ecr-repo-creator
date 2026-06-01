# ecr-repo-creator
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fbabs%2Fecr-repo-creator.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Fbabs%2Fecr-repo-creator?ref=badge_shield)


Small tool to create AWS ECR repository if missing, static build to have no dependencies.

There is also an example of Gitlab CI component that using it in [glci-example](./glci-example) ;-)

## Usage

`ecr-repo-creator [-region <region>] repo/to/create`

As `ecr-repo-creator` rely on AWS SDK, authentication uses the following environment variables:
* `AWS_PROFILE` or
* `AWS_SECRET_ACCESS_KEY`/`AWS_SESSION_TOKEN` or
* `AWS_ACCESS_KEY_ID`/`AWS_SECRET_ACCESS_KEY`


The default region is `eu-west-1`.

Repository can either be in the following form:
* just the repository name: `repository/name`
* full uri: `000000000000.dkr.ecr.eu-west-1.amazonaws.com/repository/name` (see note)


> [!CAUTION]
> Full uri is a convenient function and strips the `*.amazonaws.com` part, therefore neither `accountId` not `region` portion of the uri are used to determine the real target.
> Only the default (`eu-west-1`) or `region` flag will be used in conjunction to `accountId`, inferred from the provided credentials.

## Dockerfile

The `Dockerfile` is a convenient way to add the tool to [Kaniko](https://github.com/GoogleContainerTools/kaniko) build chain.

Build:

```bash
docker build -t new-build-image:latest --build-arg GOLANG_VERSION=1.22.5 --build-arg KANIKO_VERSION=v1.23.2 .

```

For Kaniko version: https://github.com/GoogleContainerTools/kaniko/releases

For Golang version: https://hub.docker.com/_/golang


A prebuilt image of `kaniko` with `ecr-repo-creator`, `jq` and `envsubst` is available at [ghcr.io/babs/kaniko-w-ecr-repo-creator](https://github.com/babs/ecr-repo-creator/pkgs/container/kaniko-w-ecr-repo-creator)

```bash
docker pull ghcr.io/babs/kaniko-w-ecr-repo-creator:1
```

## License
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fbabs%2Fecr-repo-creator.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Fbabs%2Fecr-repo-creator?ref=badge_large)