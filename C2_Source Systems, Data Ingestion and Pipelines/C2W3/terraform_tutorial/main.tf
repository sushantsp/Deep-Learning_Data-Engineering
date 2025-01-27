data "aws_subnets" "subnet_ids" {
    filter {
        name = "vpc-id"
        values = [var.vpc_id]
    }
}

resource "aws_db_subnet_group" "db_subnet_group" {
    subnet_ids = data.aws_subnets.subnet_ids
}


resource "aws_db_instance" "my_database" {
  username             = "admin_user"
  password             = var.db_password
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  allocated_storage    = 10
  db_name              = "mydb"
db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
}