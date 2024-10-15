# What is a data source?

  In Terraform, a data source allows you to retrieve or reference information from external systems or Terraform resources that are not part   of your current configuration. This can include querying details about existing infrastructure (e.g., an existing AWS VPC,
  images, or instances), fetching dynamic values (like available AMIs), or accessing external data like environment variables or files.
  Data sources are used in read-only mode, meaning you cannot modify or create resources through them. Instead, they help you gather       
  existing data to be used in your Terraform configuration.

# Common Use Cases for Data Sources:
  Querying cloud provider resources (like AWS, GCP, or Azure).
  Fetching available configurations such as AMIs, VPCs, or security groups.

# Step-01: Introduction
  
  Implement a sample usecase with Datasources.
  
  Get the latest Amazon Linux 2 AMI ID using datasources and reference that value when creating EC2 Instance resource ami =     
  data.aws_ami.amzlinux.id

# Step-02: Create a Datasource to fetch latest AMI ID
  
  Create or review manifest c6-ami-datasource.tf
  
  Go to AWS Mgmt Console -> Services -> EC2 -> Images -> AMI
  
  Search for "Public Images" -> Provide AMI ID
  
  We can get AMI Name format
  
  We can get Owner Name
  
  Platform
  
  Root Device Type and many more info here.
  
  Whereby build your filters in datasource

# Step-03: Create the necessary tf files as per this example and test the same.  
  
