**Life Cycle Management**
***Create_before_destroy***

This setting ensures that Terraform creates a new resource before destroying the old one. This is particularly useful when you need to make changes that require replacing an existing resource without causing downtime.

***prevent_destroy***

When set, it ensures that a resource cannot be destroyed by Terraform, even if you run terraform destroy or apply changes that would otherwise lead to the resource being destroyed.

***Ignore_Changes***

Terraform to ignore changes to specified attributes of the resource, even if they are detected as drift from the configuration. This can be useful when there are certain attributes managed outside of Terraform or expected to change frequently but not affect the desired state managed by Terraform.