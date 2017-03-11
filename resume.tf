resource "digitalocean_droplet" "resume" {
    image = ""
    name = "resume"
    region = "nyc3"
    size = "512mb"
    resize_disk = "false"

  connection {
      user = "root"
      type = "ssh"
      key_file = "${var.pvt_key}"
      timeout = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # install blueprint
      "echo \"deb http://packages.devstructure.com $(lsb_release -sc) main\" | sudo tee /etc/apt/sources.list.d/devstructure.list",
      "sudo wget -O /etc/apt/trusted.gpg.d/devstructure.gpg http://packages.devstructure.com/keyring.gpg",
      "sudo apt-get update",
      "sudo apt-get -y install blueprint"
    ]
  }
}
