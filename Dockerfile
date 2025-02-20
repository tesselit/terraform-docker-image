FROM hashicorp/terraform:1.10 as mirror

COPY .terraformrc /usr/share/terraform/terraform.tfrc

RUN terraform -help
RUN /bin/terraform providers mirror -platform=linux_arm /usr/share/terraform/providers

FROM hashicorp/terraform:1.10

COPY --from=mirror /usr/share/terraform/providers /usr/share/terraform/providers/

# TF_CLI_CONFIG_FILE="file.tfrc"
