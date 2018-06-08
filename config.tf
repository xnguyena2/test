provider "google" {
    credentials = "${file("../../google_cloud/Consorcio Interledger-90e04fe61868.json")}"
}
resource "google_compute_instance" "submiting-client-1--201806041431473796" {
    project = "awesome-icon-186722"
    machine_type = "n1-standard-2"
    zone = "us-west1-a"
    name = "submiting-client-1--201806041431473796"
    tags = ["allowall","allowalle"]
    boot_disk {
        initialize_params {
            image = "ubuntu-1604-xenial-v20180222"
        }
    }
    network_interface {
        network = "default"
        access_config {
        }
    }
    metadata {
        sshKeys = "phongtest: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCWXoNwfafanNTc57YPzyKpv9pp4uMByerdAzYfeA7mhyi8FnAGWxs6p2lQHI3Df5oOvwI6Zuu5/ZuriEUetNjKHZbxrbQASU4TNVo+zhEIRnw8EFYDR7tVMzY2fvlxgczVU++hyhw9bLa+V70gvE8c4GHefEIxXn7bZbck8HVvI1huP+jhFNfPHqUAT7x8ZpvwwL93znSERSpgljOM0Zsugw7UzTVdLLXwr8L+NWBy3baoIJ7x14urt+Am2LR3bwWWpgMZKFlzPofUTO/jsoRjv4dR6oIhYCz/5rQgu9LW85eOgMuWMo2Yf7KkIo19oFdxWX08OYPi+o16IEwi5sPz phongtest"
    }
    provisioner "remote-exec" {
        inline = [
            "curl -sSL https://6eae515100c6045c6f0a49db23b765994794909d@raw.githubusercontent.com/Multiledgers/MultiledgerAdminModule/master/Operator/baseInstall.sh -o /tmp/script.sh",
            "chmod +x /tmp/script.sh",
            "sudo bash /tmp/script.sh ",
            "sleep 3",
        ]
        connection {
            type = "ssh"
            user = "phongtest"
            private_key = "${file("../../key/test.pem")}"
            agent = false
        }
    }
}
