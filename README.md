# Large OpenAPI template

A project layout template to design and maintain a large OpenAPI 3.0 spec and generate a single
page HTML file as an output.

## Prerequisites

* NodeJS (tested with 16.x) / `npx`
* GNU Make
* Bash

## Usage

### Write

Runs Redoc CLI in watch mode and serves the documentation on [localhost:8080](http://localhost:8080)

```bash
make
make write
```

### Build

Creates `dist/LargeAPI.html`

```bash
make build
```

### Lint

Uses the IBM OpenAPI validator to lint the API spec.

```bash
make lint
```