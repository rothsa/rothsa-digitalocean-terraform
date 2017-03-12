resource "digitalocean_droplet" "blueprint" {
    image = ""
    name = "blueprint"
    region = "nyc3"
    size = "2gb"
    resize_disk = "false"

  connection {
      user = "root"
      type = "ssh"
      key_file = "${file(var.private_key_path)}"
      timeout = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # install blueprint
      "echo \"deb http://packages.devstructure.com $(lsb_release -sc) main\" | sudo tee /etc/apt/sources.list.d/devstructure.list",
      "sudo wget -O /etc/apt/trusted.gpg.d/devstructure.gpg http://packages.devstructure.com/keyring.gpg",
      "sudo apt-get update",
      "sudo apt-get -y install python-pip",
      "pip install blueprint"
    ]
  }
}