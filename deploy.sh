#!/bin/sh

set -xeu

usage() {
  cat <<'EOT'
Usage: run.sh -t <template> [-n] [-l] [-h]
  -t     CloudFormation template file name
  -n     No execute change set
  -l     Lint template
  -h     Print this help
EOT
}

no_execute_change_set_flag=false
lint_flag=false
extra_opts=""

while getopts ':t:e:nlh' args; do
  case "$args" in
    t)
      template_file="$OPTARG"
      ;;
    e)
      environment="$OPTARG"
      ;;
    n)
      no_execute_change_set_flag=true
      ;;
    l)
      lint_flag=true
      ;;
    h)
      usage
      exit 0
      ;;
    *)
      usage
      exit 1
      ;;
  esac
done

[ -f "$template_file" ] || { echo "Invalid template file: $template_file"; exit 1; }

stack_name="sam-deploy"
profile="sam-deploy"

[ "$no_execute_change_set_flag" = true ] && extra_opts="--no-execute-changeset"

pipenv run aws cloudformation validate-template \
  --template-body "file://${template_file}" \
  --profile "$profile"
$(yarn bin)/cfn-lint validate "$template_file"

[ "$lint_flag" = true ] && exit 0

pipenv run aws cloudformation deploy \
  $extra_opts \
  --template-file "$template_file" \
  --stack-name "$stack_name" \
  --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" \
  --profile "$profile"