ARG TERRAFORM_VERSION=1.10


FROM hashicorp/terraform:${TERRAFORM_VERSION} as mirror

WORKDIR /terraform

COPY terraform.tf ./terraform.tf

RUN terraform providers mirror ./providers


FROM hashicorp/terraform:${TERRAFORM_VERSION}

RUN mkdir \
  /usr/share/terraform \
  /usr/share/terraform/providers

ENV TF_CLI_CONFIG_FILE=/usr/share/terraform/terraform.tfrc

COPY .terraformrc ${TF_CLI_CONFIG_FILE}
COPY --from=mirror /terraform/providers /usr/share/terraform/providers/

WORKDIR /terraform
