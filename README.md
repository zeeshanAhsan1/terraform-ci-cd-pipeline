# terraform-ci-cd-pipeline

Deploy Infrastructure and Code in just a Click!

This repository is a complete implementation of a CI-CD pipeline. Everytime a push happens to the repository a new build is triggered via GitHub Actions.

## Technologies Used

1. FastAPI : To build an app.

2. Terraform : To implement infrastructure as a code.

3. AWS EC2 : To create a docker environment and run docker containers.

4. AWS ECR : To store docker images.

5. AWS S3 Bucket : To store the output of terraform scripts.

6. GitHub Workflows : To define the jobs of CI-CD.

## Pipeline Explained

1. Each push to this repository triggers a new build using Github Workflows.

2. In each build, the Terraform script (main.tf), allocates a new AWS EC2 instance, equips it with appropriate security groups and IAM roles, so that it can execute commands on AWS ECR to pull images. It also assigns ingress and egress rules to the instance. The Public IP is generated as an output from this terraform file.

3. The GiHub Workflows is used to assign environment variables required for the associated jobs. In the 1st job Infrastructure is deployed (EC2). In the second job FastAPI app is deployed after building and pushing the docker image to AWS ECR.

4. Then docker is installed on AWS EC2 and the pushed image on AWS ECR is pulled and deployed on the allocated AWS EC2 instance.
