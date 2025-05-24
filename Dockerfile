# syntax=docker/dockerfile:1

ARG TERRAFORM_VERSION=1.12


FROM hashicorp/terraform:${TERRAFORM_VERSION} AS mirror 

WORKDIR /terraform

COPY terraform.tf ./terraform.tf

RUN terraform providers mirror ./providers


FROM hashicorp/terraform:${TERRAFORM_VERSION}

WORKDIR /terraform

ENV TF_IN_AUTOMATION=true
ENV TF_CLI_CONFIG_FILE=/terraform/terraform.tfrc

COPY .terraformrc ${TF_CLI_CONFIG_FILE}
COPY --from=mirror /terraform/providers ./providers/

WORKDIR workspace
