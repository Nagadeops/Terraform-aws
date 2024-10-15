What is a data source?

In Terraform, a data source allows you to retrieve or reference information from external systems or Terraform resources that are not part of your current configuration. This can include querying details about existing infrastructure (e.g., an existing AWS VPC, images, or instances), fetching dynamic values (like available AMIs), or accessing external data like environment variables or files.
Data sources are used in read-only mode, meaning you cannot modify or create resources through them. Instead, they help you gather existing data to be used in your Terraform configuration.

Common Use Cases for Data Sources:
Querying cloud provider resources (like AWS, GCP, or Azure).
Fetching available configurations such as AMIs, VPCs, or security groups.
