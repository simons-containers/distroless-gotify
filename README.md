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

## Building

| Arg | Description |
|---|---|
| `GOTIFY_VERSION` | Version of Gotify to use

Build container using build-args from versions.yaml:

```bash
docker build -t \
  distroless-gotify:$(yq -r .gotify versions.yaml) \
  $(yq -r 'to_entries | .[] | "--build-arg \(.key | ascii_upcase)_VERSION=\(.value)"' versions.yaml) -f Containerfile .
```

## License

Repository contents (e.g., `Containerfile`, build scripts, and configuration) are licensed under the **MIT License**.

Software included in built container images (such as **Gotify**) are provided under their respective upstream licenses and are not covered by the MIT license for this repository.

## Acknowledgements

This project depends on a number of upstream components and data sources:

- **Gotify** - A simple server for sending and receiving messages in real-time per WebSocket. (Includes a sleek web-ui)
  https://gotify.net
