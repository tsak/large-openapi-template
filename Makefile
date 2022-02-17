.PHONY: write create build bundle lint

write:
	npx redoc-cli --options.expandResponses="200,201" serve api.yaml --watch

build:
	mkdir -p dist
	npx redoc-cli --options.expandResponses="200,201" bundle api.yaml
	mv redoc-static.html dist/LargeAPI.html

lint:
	npx ibm-openapi-validator --errors_only --verbose api.yaml