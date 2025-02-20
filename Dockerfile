ARG IMAGE=hashicorp/terraform
ARG TAG=1.10

FROM $IMAGE:$TAG as mirror

WORKDIR /terraform
COPY terraform.tf terraform.tf
CMD providers mirror -platform=linux_arm providers

FROM $IMAGE:$TAG

RUN mkdir /usr/share/terraform
ENV TF_CLI_CONFIG_FILE="/usr/share/terraform/terraform.tfrc"
COPY .terraformrc ${TF_CLI_CONFIG_FILE}

RUN mkdir /usr/share/terraform/providers
COPY --from=mirror /terraform/providers /usr/share/terraform/providers/
