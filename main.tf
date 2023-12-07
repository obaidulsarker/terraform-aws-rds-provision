provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS region
}

variable "instance_count" {
  default = 2           # How many RDS instances do you want?
}

variable "db_instance_identifiers" {
  type    = list(string)
  default = ["db-instance-1", "db-instance-2"]  # provide each instance unique name
}

variable "db_instance_class" {
  type    = list(string)
  default = ["db.m5d.large", "db.m5d.large"]  # provide each instance class / machine type
}

variable "allocated_storage" {
  type    = list(number)
  default = [100, 100]                       # provide each instance storage size in GB
}

variable "db_engine_version" {
  type    = list(string)
  default = ["13.13", "15.4"]                 # provide each instance database version
}

resource "aws_db_instance" "postgresql_rds" {
  count                  = var.instance_count
  identifier             = var.db_instance_identifiers[count.index]
  allocated_storage      = var.allocated_storage[count.index]
  storage_type          = "gp2"
  engine                 = "postgres"
  engine_version         = var.db_engine_version[count.index]
  instance_class         = var.db_instance_class[count.index]
  username               = "obaidul"  # Modify as needed
  password               = "asd#^*02jkas5238343"              # database password
  publicly_accessible   = false                               # Modify as needed
  skip_final_snapshot    = true

  # Configure other settings as needed

  tags = {
    Name = "postgresql-rds-${count.index}"
  }
}
