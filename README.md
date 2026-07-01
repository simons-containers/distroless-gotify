[![Current Version](https://raw.githubusercontent.com/simons-containers/distroless-gotify/badges/.badges/main/release.svg)](https://github.com/simons-containers/distroless-gotify/pkgs/container/distroless-gotify) [![Tags](https://raw.githubusercontent.com/simons-containers/distroless-gotify/badges/.badges/main/tags.svg)](https://github.com/simons-containers/distroless-gotify/pkgs/container/distroless-gotify) <br> ![Current Size](https://raw.githubusercontent.com/simons-containers/distroless-gotify/badges/.badges/main/size.svg) ![Wasted Size](https://raw.githubusercontent.com/simons-containers/distroless-gotify/badges/.badges/main/wasted.svg) ![Efficiency](https://raw.githubusercontent.com/simons-containers/distroless-gotify/badges/.badges/main/efficiency.svg) <br> ![Critical](https://raw.githubusercontent.com/simons-containers/distroless-gotify/badges/.badges/main/critical.svg) ![High](https://raw.githubusercontent.com/simons-containers/distroless-gotify/badges/.badges/main/high.svg) ![Medium](https://raw.githubusercontent.com/simons-containers/distroless-gotify/badges/.badges/main/medium.svg) ![Low](https://raw.githubusercontent.com/simons-containers/distroless-gotify/badges/.badges/main/low.svg) <br> [![Publish Workflow](https://img.shields.io/github/actions/workflow/status/simons-containers/distroless-gotify/deploy.yaml?label=Publish%20Workflow&logo=github)](https://github.com/simons-containers/distroless-gotify/actions/workflows/deploy.yaml) [![Update Workflow](https://img.shields.io/github/actions/workflow/status/simons-containers/distroless-gotify/update-versions.yaml?label=Update%20Workflow&logo=github)](https://github.com/simons-containers/distroless-gotify/actions/workflows/update-versions.yaml)

# Distroless Gotify container

Bare-bones distroless Gotify container image.

## Running

Mount a persistent data volume at `/var/lib/gotify`. Mount configuration at `/etc/gotify/config.yml` or configure with environment variables.

Example:

```bash
docker run -it --rm \
  -v data:/var/lib/gotify \
  -e GOTIFY_SERVER_PORT=8080 \
  -p 8080:8080 \
  ghcr.io/simons-containers/distroless-gotify:latest
```

## License

Repository contents (e.g., `Containerfile`, build scripts, and configuration) are licensed under the **MIT License**.

Software included in built container images (such as **Gotify**) are provided under their respective upstream licenses and are not covered by the MIT license for this repository.

## Acknowledgements

This project depends on a number of upstream components and data sources:

- **Gotify** - A simple server for sending and receiving messages in real-time per WebSocket. (Includes a sleek web-ui)
  https://gotify.net
