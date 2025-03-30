resource "aws_instance" "fe" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = var.fe_sg_ids
  user_data              = <<-EOF
    #!/bin/bash
    sudo sed -i 's/^#Port 22/Port 8080/' /etc/ssh/sshd_config
    sudo sed -i 's/^Port 22/Port 8080/' /etc/ssh/sshd_config
    sudo echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
    sudo systemctl restart sshd
    sudo apt install -y net-tools
    sudo apt install -y nginx
    sudo systemctl enable nginx
    sudo systemctl start nginx
    
    sudo mkdir -p /var/www/html
    sudo cat <<EOT > /var/www/html/index.html
    <!DOCTYPE html>
    <html>
    <head>
        <title>Simple CRUD</title>
        <script>
            const apiBase = 'http://${aws_instance.be.private_ip}:3000/users';
            async function fetchUsers() {
                let response = await fetch(apiBase);
                let users = await response.json();
                document.getElementById('users').innerText = JSON.stringify(users, null, 2);
            }
            async function addUser() {
                let name = prompt('Enter name:');
                await fetch(apiBase, { method: 'POST', headers: {'Content-Type': 'application/json'}, body: JSON.stringify({ name }) });
                fetchUsers();
            }
        </script>
    </head>
    <body onload="fetchUsers()">
        <h1>User List</h1>
        <pre id="users"></pre>
        <button onclick="addUser()">Add User</button>
    </body>
    </html>
    EOT
    
    sudo systemctl restart nginx
    EOF

  tags = {
    Name = "fe"
  }
}

resource "aws_instance" "be" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = var.be_sg_ids
  user_data              = <<-EOF
    #!/bin/bash
    export DEBIAN_FRONTEND=noninteractive

    sudo sed -i 's/^#Port 22/Port 8080/' /etc/ssh/sshd_config
    sudo sed -i 's/^Port 22/Port 8080/' /etc/ssh/sshd_config
    sudo echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
    sudo systemctl restart sshd
    sudo apt install -y net-tools
    curl -fsSL https://rpm.nodesource.com/setup_18.x | bash -
    sudo apt install -y nodejs mysql-client
    
    sudo cat <<EOT > /home/ubuntu/server.js
    const express = require('express');
    const mysql = require('mysql');
    const cors = require("cors");
    const app = express();
    app.use(express.json());
    app.use(cors());
    
    const db = mysql.createConnection({
        host: '${aws_instance.database.private_ip}',
        user: 'admin',
        password: 'Quang14@',
        port: 3306,
        database: 'testdb'
    });
    db.connect();
    
    app.get('/users', (req, res) => {
        db.query('SELECT * FROM users', (err, result) => res.json(result));
    });
    
    app.post('/users', (req, res) => {
        db.query('INSERT INTO users (name) VALUES (?)', [req.body.name], () => res.send('User added'));
    });
    
    app.listen(3000, () => console.log('Server running on port 3000'));
    EOT
    
    sudo chmod +x /home/ubuntu/server.js
    cat <<EOT > /etc/systemd/system/backend.service
    [Unit]
    Description=Backend Node.js Service
    After=network.target

    [Service]
    ExecStart=/usr/bin/node /home/ubuntu/server.js
    Restart=always
    User=ubuntu
    Group=ubuntu
    Environment=PATH=/usr/bin:/usr/local/bin
    Environment=NODE_ENV=production
    WorkingDirectory=/home/ubuntu

    [Install]
    WantedBy=multi-user.target
    EOT

    sudo systemctl daemon-reload
    sudo systemctl enable backend.service
    sudo systemctl start backend.service
    EOF

  tags = {
    Name = "be"
  }
}

resource "aws_instance" "database" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = var.db_sg_ids
  user_data              = <<-EOF
    #!/bin/bash
    sudo sed -i 's/^#Port 22/Port 8080/' /etc/ssh/sshd_config
    sudo sed -i 's/^Port 22/Port 8080/' /etc/ssh/sshd_config
    sudo echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
    sudo systemctl restart sshd
    sudo apt install -y net-tools
    sudo apt install -y mysql-server
    sudo mysql -e "CREATE USER 'admin'@'%' IDENTIFIED BY 'Quang14@';"
    sudo mysql -e "GRANT ALL PRIVILEGES ON testdb.* TO 'admin'@'%';"
    sudo mysql -e "FLUSH PRIVILEGES;"
    sudo mysql -u root -e "CREATE DATABASE testdb;"
    sudo mysql -u root -e "USE testdb; CREATE TABLE users (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100));"
    EOF
  tags = {
    Name = "database"
  }
}

resource "aws_instance" "bastion" {
  ami                    = var.ami_id
  instance_type          = var.bastion_instance_type
  subnet_id              = var.public_subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = var.bastion_sg_ids
  user_data              = <<-EOF
    #!/bin/bash
    sudo sed -i 's/^#Port 22/Port 8080/' /etc/ssh/sshd_config
    sudo sed -i 's/^Port 22/Port 8080/' /etc/ssh/sshd_config
    sudo echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
    sudo systemctl restart sshd
    sudo apt install -y net-tools
    EOF

  tags = {
    Name = "bastion"
  }
}
