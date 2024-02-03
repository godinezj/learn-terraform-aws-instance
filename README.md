# learn-terraform-aws-instance
`tfsec` is pretty cool

Checkout `tfsec` GitHub action:
.github/workflows/tgsec.yml:
```
name: tfsec
on:
  push:
    branches:
      - main
  pull_request:
jobs:
  tfsec:
    name: tfsec
    runs-on: ubuntu-latest

    steps:
      - name: Clone repo
        uses: actions/checkout@master
      - name: tfsec
        uses: aquasecurity/tfsec-action@v1.0.0
```

Here is the Actions output of running `tfsec` by hand:
```
tfsec is joining the Trivy family

tfsec will continue to remain available 
for the time being, although our engineering 
attention will be directed at Trivy going forward.

You can read more here: 
https://github.com/aquasecurity/tfsec/discussions/1994
======================================================

Result #1 HIGH Instance does not require IMDS access to require a token 
────────────────────────────────────────────────────────────────────────────────
  main.tf:16-24
────────────────────────────────────────────────────────────────────────────────
   16    resource "aws_instance" "bastion" {
   17      ami           = "ami-08d70e59c07c61a3a"
   18      instance_type = "t2.micro"
   19      key_name      = "javier"
   20      subnet_id     = "subnet-a9d32fc2"
   21      tags = {
   22        Name = "Bastion"
   23      }
   24    }
────────────────────────────────────────────────────────────────────────────────
          ID aws-ec2-enforce-http-token-imds
      Impact Instance metadata service can be interacted with freely
  Resolution Enable HTTP token requirement for IMDS

  More Information
  - https://aquasecurity.github.io/tfsec/v1.28.4/checks/aws/ec2/enforce-http-token-imds/
  - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#metadata-options
────────────────────────────────────────────────────────────────────────────────


Result #2 HIGH Root block device is not encrypted. 
────────────────────────────────────────────────────────────────────────────────
  main.tf:16-24
────────────────────────────────────────────────────────────────────────────────
   16    resource "aws_instance" "bastion" {
   17      ami           = "ami-08d70e59c07c61a3a"
   18      instance_type = "t2.micro"
   19      key_name      = "javier"
   20      subnet_id     = "subnet-a9d32fc2"
   21      tags = {
   22        Name = "Bastion"
   23      }
   24    }
────────────────────────────────────────────────────────────────────────────────
          ID aws-ec2-enable-at-rest-encryption
      Impact The block device could be compromised and read from
  Resolution Turn on encryption for all block devices

  More Information
  - https://aquasecurity.github.io/tfsec/v1.28.4/checks/aws/ec2/enable-at-rest-encryption/
  - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#ebs-ephemeral-and-root-block-devices
────────────────────────────────────────────────────────────────────────────────


Result #3 HIGH Instance does not require IMDS access to require a token 
────────────────────────────────────────────────────────────────────────────────
  main.tf:26-34
────────────────────────────────────────────────────────────────────────────────
   26    resource "aws_instance" "app_server" {
   27      ami           = "ami-08d70e59c07c61a3a"
   28      instance_type = "t2.micro"
   29      key_name      = "javier"
   30      subnet_id     = "subnet-00c81127c4cf2ac81"
   31      tags = {
   32        Name = "appserver"
   33      }
   34    }
────────────────────────────────────────────────────────────────────────────────
          ID aws-ec2-enforce-http-token-imds
      Impact Instance metadata service can be interacted with freely
  Resolution Enable HTTP token requirement for IMDS

  More Information
  - https://aquasecurity.github.io/tfsec/v1.28.4/checks/aws/ec2/enforce-http-token-imds/
  - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#metadata-options
────────────────────────────────────────────────────────────────────────────────


Result #4 HIGH Root block device is not encrypted. 
────────────────────────────────────────────────────────────────────────────────
  main.tf:26-34
────────────────────────────────────────────────────────────────────────────────
   26    resource "aws_instance" "app_server" {
   27      ami           = "ami-08d70e59c07c61a3a"
   28      instance_type = "t2.micro"
   29      key_name      = "javier"
   30      subnet_id     = "subnet-00c81127c4cf2ac81"
   31      tags = {
   32        Name = "appserver"
   33      }
   34    }
────────────────────────────────────────────────────────────────────────────────
          ID aws-ec2-enable-at-rest-encryption
      Impact The block device could be compromised and read from
  Resolution Turn on encryption for all block devices

  More Information
  - https://aquasecurity.github.io/tfsec/v1.28.4/checks/aws/ec2/enable-at-rest-encryption/
  - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#ebs-ephemeral-and-root-block-devices
────────────────────────────────────────────────────────────────────────────────


  timings
  ──────────────────────────────────────────
  disk i/o             48.871µs
  parsing              277.415µs
  adaptation           82.072µs
  checks               3.39173ms
  total                3.800088ms

  counts
  ──────────────────────────────────────────
  modules downloaded   0
  modules processed    1
  blocks processed     7
  files read           3

  results
  ──────────────────────────────────────────
  passed               2
  ignored              0
  critical             0
  high                 4
  medium               0
  low                  0

  2 passed, 4 potential problem(s) detected.
```
