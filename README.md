# cf-tools
Dockerfile for building CF-Tools container image

Container image contains the following tools:

- CF CLI
- BOSH CLI
- UAAC CLI
- CFDOT CLI
- Minio Client
- Go 1.11.2
- AWS CLI
- SUSE Backup Plugin
- Usage Report Plugin

Dockerfile was originally taken from https://github.com/pivotalservices/concourse-pipeline-samples/blob/master/common/docker-images/multi-purpose-ubuntu/Dockerfile and it was modified and streamlined.

The container image is built based on Ubuntu 18.04 + updates (as of 11/08/18)
