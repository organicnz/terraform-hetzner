resource "hcloud_server" "web" {
  name        = var.server_name
  server_type = "cx22"
  image       = var.image
  location    = var.location
  ssh_keys    = [hcloud_ssh_key.default.id]
  
  labels = {
    environment = var.environment
  }
  
  # Commented out as we're using Ansible for configuration instead
  # user_data = file("${path.module}/user_data.sh")
  
  # Enable backups if specified
  backups = var.enable_backups
}

resource "hcloud_ssh_key" "default" {
  name       = "${var.server_name}-key"
  public_key = file(var.ssh_public_key_path)
}

resource "hcloud_firewall" "web" {
  name = "${var.server_name}-firewall"
  
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = var.allowed_ssh_ips
  }
  
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "80"
    source_ips = ["0.0.0.0/0", "::/0"]
  }
  
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "443"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  # ICMP (ping)
  rule {
    direction  = "in"
    protocol   = "icmp"
    source_ips = ["0.0.0.0/0", "::/0"]
  }
}

resource "hcloud_firewall_attachment" "web" {
  firewall_id = hcloud_firewall.web.id
  server_ids  = [hcloud_server.web.id]
} 