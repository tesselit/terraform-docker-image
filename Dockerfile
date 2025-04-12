ARG TERRAFORM_VERSION=1.11


FROM hashicorp/terraform:${TERRAFORM_VERSION} as mirror

WORKDIR /terraform

COPY terraform.tf ./terraform.tf

RUN terraform providers mirror ./providers


FROM hashicorp/terraform:${TERRAFORM_VERSION}

ENV TF_IN_AUTOMATION=true
ENV TF_CLI_CONFIG_FILE=/usr/share/terraform/terraform.tfrc

COPY .terraformrc ${TF_CLI_CONFIG_FILE}
COPY --from=mirror /terraform/providers /usr/share/terraform/providers/

WORKDIR /terraform
