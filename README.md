# The project is designed to automate the deployment of infrastructure and a Dockerized application using Terraform, AWS services, and GitHub Actions. 

Here's an overview of the key components and steps involved in the project:

Project Overview: Continuous Deployment with Terraform and Docker

Workflow Triggers: The workflow is triggered on every push to the main branch of the repository. This means that whenever changes are pushed to the main branch, the workflow will be executed to deploy the infrastructure and application.

Environment Variables: The workflow uses GitHub Secrets to store sensitive information such as AWS access keys, SSH keys, and other configuration variables. These environment variables are used to authenticate and configure interactions with AWS services and the deployment process.

Deploy Infrastructure Job:

This job is responsible for provisioning the required infrastructure using Terraform.
It runs on an Ubuntu-latest runner.
It initializes Terraform, sets up the backend configuration, and then plans and applies the infrastructure changes.
The outputs from this job include the public IP address of the deployed instance, which will be used in the subsequent steps.
Deploy App Job:

This job depends on the successful completion of the deploy-infrastructure job.
It is responsible for building and deploying the Dockerized application.
It runs on an Ubuntu-latest runner.
It starts by checking out the code and then sets environment variables with the public IP address obtained from the previous job.
The job logs into AWS ECR, builds the Docker image of the application, pushes it to the ECR repository, and finally deploys the Docker container on an EC2 instance.
This job completes the deployment process by deploying the application on the provisioned infrastructure.
Key Takeaways:

The project combines infrastructure provisioning with application deployment using GitHub Actions and Terraform.
GitHub Secrets are used to securely store sensitive credentials and configuration.
The project assumes that the Terraform configuration and Docker setup are correctly defined in the repository.
The workflow relies on GitHub Actions' runner environment and Docker to build and deploy the application image.
The working directory is used to control the context for different steps, ensuring that commands are executed in the correct directories.
Note: While the provided workflow and project structure seem comprehensive, the effectiveness of the solution depends on accurate configurations, proper repository structure, and alignment with your specific application and infrastructure requirements. Always perform thorough testing in a controlled environment before deploying to production.



