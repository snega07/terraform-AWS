## Terraform lifecycle rules

**action_trigger** -> Triggers action based on event or conditions. Action specifies what to do like restart an instance and other.

**create_before_destroy** -> Terraform by default destroy the existing object and create the new one. This make sure resources are created before destroying. 

Pros:
Zero downtime for ec2 instance or autoscaling groups
Note:
If create before destory is enabled on resource A not on B. Since resource A is dependent on B terraform enbales it implicitly and stores it in state file.

**prevent_destroy** -> Prevent accidental deletion of resources. This is applicable only if the resource configuration exists and lifecyle argument presents.

Pros: Suitable for critical resources like RDS, S3 bucket with important data, production VPC.

**Ignore_changes** -> Ignore changes on further tf apply that are done mannually in UI for the resource created by terraform.

Pros: Ignore changes made by other IAAC or through UI. Terraform ignores drift detacted during tf plan.

**replace_triggered_by** -> Terraform replaces the resource when any of the referenced resources or specified attributes change. Supply a list of expressions that reference managed resources, instances, or instance attributes.

Pros: recreate the resources based on the chages in the attribute of another resources. Change in EC2 autoscaling templates recreates Autoscaling groups.

**pre and post condition** -> Specifies a condition that Terraform evaluates before or after creating the resource.
Pros: evaluate moniroting enabled for resource are not. 
Post condition checks like whether public IP assinged for the newly created resource.
