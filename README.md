AWSSAMDeployEnvironmentConstruction
=======

# Requirements

- [AWS CLI](https://aws.amazon.com/cli/)
- [Docker for Mac](https://www.docker.com/docker-mac)
- [yarn](https://yarnpkg.com)

# Setting

```bash
$ yarn install
```

# Deploy

## 1. Configure AWS credentials

- `~/.aws/credentials`

```bash
[sam-deploy]
aws_access_key_id = <your_aws_access_key_id>
aws_secret_access_key = <your_aws_secret_access_key>
```

- `~/.aws/config`

```bash
[profile sam-deploy]
region = ap-northeast-1
output = json
```

## 2. Docker image build

```bash
$ ./build.sh
```

## 3. Deploy

```bash
$ ./run.sh -t sam-deploy.yml
```

# Output

- SAMArtifactBucketName: `sam-artifacts-<your_account_id>-ap-northeast-1`
- SAMDeployRoleArn: `arn:aws:iam::<your_account_id>:role/sam-deploy/sam-deploy-role`
