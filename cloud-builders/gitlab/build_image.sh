#!/bin/bash

decrypted_file=$(mktemp /tmp/XXXXXX.yml)

function cleanup {
  rm -rf "$decrypted_file"
}
trap cleanup EXIT

ansible-vault view vault.yml > "$decrypted_file"
cat "$decrypted_file" | yq .gitlab.root_password | tr -d '"\n' > swarm/root_password.txt
cat "$decrypted_file" | yq .gitlab.runner_token | tr -d '"\n' > swarm/runner_token.txt
jinja2 -D runner_token=$(cat "$decrypted_file" | yq .gitlab.runner_token) -o swarm/config.toml swarm/config.toml.j2

gcloud builds submit --config cloudbuild.yml .
