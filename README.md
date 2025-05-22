# Hetzner Cloud Terraform Configuration

This Terraform configuration provisions a CX22 VPS on Hetzner Cloud with the following specifications:

- Server Type: CX22
- vCPUs: 2
- RAM: 4 GB
- Storage: 40 GB
- Traffic: 20 TB
- Price: $0.0074/hour

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (v1.0.0 or newer)
- Hetzner Cloud account
- Hetzner Cloud API token
- SSH key pair

## Setup

1. Clone this repository:
```bash
git clone https://github.com/yourusername/terraform-hetzner.git
cd terraform-hetzner
```

2. Configure your Hetzner API token using one of these methods:

   **Method 1: Using .env.local (Recommended)**
   ```bash
   echo "TF_VAR_hcloud_token=your_hetzner_api_token" > .env.local
   chmod 600 .env.local  # Secure the file
   ```
   Then use the provided script to run Terraform commands:
   ```bash
   ./run-terraform.sh plan
   ./run-terraform.sh apply
   ```

   **Method 2: Using terraform.tfvars**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars and add your token
   ```

   **Method 3: Using environment variables directly**
   ```bash
   export TF_VAR_hcloud_token="your_hetzner_api_token"
   ```

3. Customize other settings as needed in terraform.tfvars:
```
ssh_public_key_path = "~/.ssh/id_rsa.pub"
allowed_ssh_ips = ["your_ip_address/32"]
```

## Usage

1. Initialize Terraform:
```bash
terraform init
```
Or using the script:
```bash
./run-terraform.sh init
```

2. Preview the changes:
```bash
terraform plan
```
Or using the script:
```bash
./run-terraform.sh plan
```

3. Apply the configuration:
```bash
terraform apply
```
Or using the script:
```bash
./run-terraform.sh apply
```

4. To destroy the resources when no longer needed:
```bash
terraform destroy
```
Or using the script:
```bash
./run-terraform.sh destroy
```

## Configuration Options

All configuration options are defined in `variables.tf`. Key variables include:

| Variable | Description | Default |
|----------|-------------|---------|
| hcloud_token | Hetzner Cloud API Token | - |
| server_name | Name of the server | hetzner-cx22 |
| image | OS image to use | ubuntu-22.04 |
| location | Datacenter location | nbg1 (Nuremberg) |
| ssh_public_key_path | Path to your SSH public key | ~/.ssh/id_rsa.pub |
| enable_backups | Enable server backups | false |
| allowed_ssh_ips | IPs allowed to connect via SSH | ["0.0.0.0/0"] |
| environment | Environment tag | production |

## Security

- The configuration sets up a basic firewall allowing SSH, HTTP, and HTTPS traffic.
- For production use, it's recommended to restrict SSH access to specific IP addresses.
- The server is configured with automatic security updates.

## Customization

- You can modify the `user_data.sh` script to customize server initialization.
- Additional server resources or configurations can be added to `main.tf`.

## License

This project is licensed under the MIT License - see the LICENSE file for details. 