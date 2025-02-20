ARG IMAGE=hashicorp/terraform
ARG TAG=1.10

FROM $IMAGE:$TAG as mirror

WORKDIR /terraform

COPY terraform.tf terraform.tf

RUN terraform providers mirror -platform=linux_arm providers

FROM $IMAGE:$TAG

RUN mkdir \
  /usr/share/terraform \
  /usr/share/terraform/providers

ENV TF_CLI_CONFIG_FILE="/usr/share/terraform/terraform.tfrc"
COPY .terraformrc ${TF_CLI_CONFIG_FILE}

COPY --from=mirror /terraform/providers /usr/share/terraform/providers/
