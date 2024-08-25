# Terraform modules

In Terraform, modules are a fundamental way to organize and reuse infrastructure code. A module is a container for multiple resources that are used together. Modules enable you to define reusable infrastructure components, making your Terraform configurations more modular, manageable, and maintainable.

# Key Concepts of Terraform Modules:

Root Module:
Every Terraform configuration has at least one module, known as the root module. The root module is simply the configuration located in the directory where you run the terraform command.
It consists of .tf files that define resources, data sources, variables, outputs, and more.

Child Modules:
A module that is called from within another module is referred to as a child module.
Child modules are defined in their own directories and can be invoked from the root module or other modules.
Modules can be sourced locally (from a directory) or remotely (e.g., from a Git repository or the Terraform Registry).

# Module Composition:

A module typically consists of multiple .tf files, and it can include:
Resources: Definitions of the infrastructure resources the module will manage.
Variables: Inputs that allow the module to be customized when it is used.
Outputs: Values that are exposed to the calling module, allowing data to be passed between modules.
Providers: Definitions of the providers the module depends on.
Data Sources: External data that the module can use to configure resources.
Module Reusability: Modules can be reused across different Terraform configurations by passing different input variables.
This enables you to write a module once and apply it in different contexts, such as different environments, regions, or projects.

# A Simple Terraform Module
Let's create a simple module that provisions an AWS EC2 instance.
Step 1: Create a directory for your module:

