InfraBlueprint — Submission

Summary

I built Terraform code for a two-tier web app layout with a custom VPC, public and private subnets, EC2, RDS, and S3. I also used modules for the main parts of the stack.

Quick links

- Terraform code: [infra](infra)
- Modules: [infra/modules](infra/modules)
- Example variables: [example.tfvars](../example.tfvars)

How to validate (no apply required)

1. Initialize and validate the configuration:

```bash
cd InfraBlueprint/infra
terraform init -input=false
terraform validate
terraform fmt -recursive
terraform plan -var-file="../example.tfvars"
```

2. `terraform plan` should complete without errors. I used `plan` as the validation step for this submission.

Variables and example values

- See `example.tfvars` for placeholder values. The main inputs are `aws_region`, `my_ip_cidr`, `db_username`, `db_password`, and `s3_bucket_name`.

Design decisions

- Modules: I split the code into `networking`, `compute`, `database`, and `storage` modules so it is easier to follow.
- Private subnets for RDS: I kept RDS private so it is not exposed to the internet.

Attempted bonuses

- The bonus project I did was modules.

Implementation notes

- EC2 instance type: the code uses `t3.micro`.
- AMI selection: I used Ubuntu for this build.
- Backend configuration is documented in the write-up.
- Terraform state files are included as part of the repository state for this challenge.

References

- Module sources: [infra/modules](infra/modules)
- Example variables: [example.tfvars](../example.tfvars)
