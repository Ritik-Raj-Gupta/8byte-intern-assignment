## Containerization (Docker)
I used Docker to package the application and its dependencies into a single portable unit.

Key decisions:
- **Lightweight base image** (`node:alpine`) to reduce image size
- **WORKDIR usage** to maintain a consistent directory structure
- **Layered build** by copying `package.json` before running `npm install` to improve build efficiency

This ensures that the application runs consistently across local, CI, and cloud environments.
---

## Infrastructure as Code (Terraform)
Terraform was used to provision AWS infrastructure in a declarative and repeatable way.

Resources created:
- Virtual Private Cloud (VPC)
- Public subnet with internet access
- Internet Gateway and route table
- Security Group allowing SSH (22) and application access (3000)
- EC2 instance running Ubuntu 22.04

Docker is installed automatically on the EC2 instance using `user_data`, eliminating the need for manual setup.

Using Terraform ensures:
- Infrastructure can be recreated reliably
- Configuration is version-controlled
- Manual cloud setup is avoided
---

## CI/CD Pipeline (GitHub Actions)
GitHub Actions was used to automate Docker image builds and pushing.
Pipeline behavior:
- Triggered on every push to the `main` branch
- Builds the Docker image from the repository
- Logs in to Docker Hub using GitHub Secrets
- Pushes the image with the `latest` tag

This ensures that every code change results in an updated, deployable Docker image.
---

## Conclusion
The approach I have used is a simple but complete DevOps workflow using:
- Docker for containerization
- Terraform for infrastructure automation
- GitHub Actions for CI/CD