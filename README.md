# Terraform-aws

# What is Terraform?

Terraform is an infrastructure-as-code software tool created by HashiCorp, an IAC tool, used primarily by DevOps teams to automate various infrastructure tasks.
It allows users to define and manage infrastructure resources, such as virtual machines, networks, databases, and more using a high-level configuration language called HashiCorp Configuration Language (HCL).
With Terraform, you can provision, update, and version your infrastructure in a consistent, predictable, and automated way.

# How Terraform Works:

Write Configuration: You define your infrastructure in .tf files using HCL. These files describe the desired state of your infrastructure.

Initialize Terraform: You run terraform init to initialize your Terraform working directory. This command downloads the necessary provider plugins and prepares your environment for Terraform operations.

Create an Execution Plan: You run terraform plan to create an execution plan. Terraform compares the desired state defined in your configuration files with the current state of your infrastructure and shows you what changes it will make.

Apply the Changes: If you're satisfied with the execution plan, you run terraform apply to apply the changes and bring your infrastructure to the desired state.

Manage the State: Terraform stores the state of your infrastructure in a state file, which it uses to track resource changes over time. This file can be stored locally or in a remote backend for collaboration.

Update or Destroy Infrastructure: You can update your infrastructure by modifying your configuration files and running terraform apply again. To remove resources, you can run terraform destroy.

# Example Terraform Configuration

Here's a simple example that provisions an EC2 instance on AWS:

![image](https://github.com/user-attachments/assets/95cd38f0-4e18-4ffb-b52d-6577c925443d)

Provider Block: Specifies the cloud provider (AWS in this case) and the region.

Resource Block: Defines an EC2 instance resource with a specific AMI ID and instance type. The tags block adds metadata to the instance.
