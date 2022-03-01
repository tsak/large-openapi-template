# Large OpenAPI template

A project layout template to design and maintain a large OpenAPI 3.0 spec and generate a single
page HTML file as an output.

## Prerequisites

* NodeJS (tested with 16.x) / `npx`
* GNU Make
* Bash (for create script)

## Usage

### Write

Runs Redoc CLI in watch mode and serves the documentation on [localhost:8080](http://localhost:8080)

```bash
make # defaults to write
```

### Add endpoint

Using the templates in `.template`, create a new endpoint and add references in `api.yaml`

```bash
./create.bash <name> <directory>
```

- `name` name of the endpoint to be created, this is used for tags, etc. Use singular, e.g. `pet`
- `directory` where to put template output, e.g. `pets`. You can also use subdirectories, e.g. `pets/dogs`

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