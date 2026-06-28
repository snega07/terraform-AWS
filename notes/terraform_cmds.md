terraform init
terraform plan
terraform apply
terraform apply --auto-approve
terraform destroy

**State file**
tfstate 
remote backend

if the state file is lost or misconfigured. This will cause distruption in our infrastructure creation and terraform will loose its memory of the resources that are created.

State locking -> helps to lock the state file to make sure only single process use the state file at a time. 
Also keeps sensitive data safely if stored in a proper remote backends like S3.

tf state list

partial confgiguration
consul s3