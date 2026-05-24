resource "aws_security_group" "db_sg" {
  name        = "vela-payments-db-sg"
  description = "Allow Postgres from web SG"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.web_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "vela-payments-db-sg"
    Project = var.project_tag
  }
}

resource "aws_db_subnet_group" "main" {
  name       = "vela-payments-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name    = "vela-payments-db-subnet-group"
    Project = var.project_tag
  }
}

resource "aws_db_instance" "main" {
  identifier             = "vela-payments-db"
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "15"
  instance_class         = "db.t3.micro"
  db_name                = "vela_payments"
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  tags = {
    Name    = "vela-payments-rds"
    Project = var.project_tag
  }
}