FROM hashicorp/terraform:1.10 as mirror

WORKDIR /terraform

COPY terraform.tf terraform.tf

CMD providers mirror -platform=linux_arm providers

FROM hashicorp/terraform:1.10

# WORKDIR /terraform

# COPY --from=mirror /terraform /terraform/

# TF_CLI_CONFIG_FILE="file.tfrc"
