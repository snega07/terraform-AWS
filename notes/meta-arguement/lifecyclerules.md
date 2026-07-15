## Terraform lifecycle rules

**action_trigger** -> Triggers action based on event or conditions. Action specifies what to do.

**create_before_destroy** -> Terraform by default destroy the existing object and create the new one. This make sure resources are created before destroying.
Note:
If create before destory is enabled on resource A not on B. Since resource A is dependent on B terraform enbales it implicitly and stores it in state file.

**prevent_destroy** -> Prevent accidental deletion of resources. This is applicable only if the resource configuration exists and lifecyle argument presents.

**Ignore_changes** -> Ignore changes on further tf apply that are done mannually in UI for the resource created by terraform.

**replace_triggered_by** -> Terraform replaces the resource when any of the referenced resources or specified attributes change. Supply a list of expressions that reference managed resources, instances, or instance attributes.

**pre and post condition** -> Specifies a condition that Terraform evaluates before or after creating the resource
