#!/usr/bin/env bash

# Adds a new endpoint and model in the given directory based on the template
if [[ -z "$1" ]] || [[ -z "$2" ]]; then
    echo "Please run: '$0 <name> <directory>' or '$0 <name> <directory/subdirectory>'"
    exit 1
fi

set -euo pipefail

name=$1
NAME=${name^} # Uppercase first letter
dir=$2

if [[ ! -d "$dir" ]]; then
    mkdir -p "$dir"
fi

cp -nv ./.template/path.yaml "$dir/"
cp -nv ./.template/path-by-id.yaml "$dir/"
cp -nv ./.template/model.yaml "$dir/"
cp -nv ./.template/400.yaml "$dir/"
cp -nv ./.template/404.yaml "$dir/"

# Get relative path prefix for relative links from created dir to root
path_prefix="$(realpath . --relative-to "$dir")/"

(
    cd "$dir" || exit 1

    # Replace name in templates
    for template in ./path.yaml ./path-by-id.yaml ./model.yaml ./400.yaml ./404.yaml ; do
        sed -i "s/_name_/$name/g" "$template"
        sed -i "s/_Name_/$NAME/g" "$template"
        sed -i "s#\.\./#${path_prefix}#g" "$template"
    done
)

# Insert new tag
sed -i "/^tags:/a\  - name: ${NAME}\n    description: |\n      Describe what ${NAME} is used for..." api.yaml

# Insert new path
sed -i "/^paths:/a\  \/${dir}:\n    \$ref: .\/${dir}/\path.yaml\n  '\/${dir}/{id}':\n    \$ref: .\/${dir}/\path-by-id.yaml\n" api.yaml

# Insert model component
sed -i "/^  schemas:/a\    $NAME:\n      \$ref: .\/${dir}s/\model.yaml" api.yaml
