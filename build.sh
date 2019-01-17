#!/usr/bin/env bash

set -xeuo pipefail

image_name="sam-deploy-cfn"

docker image build --tag "$image_name" .
