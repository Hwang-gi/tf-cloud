# DB 서브넷 그룹
resource "aws_db_subnet_group" "DB_SUBG" {
  name       = "db-subg"
  subnet_ids = var.rds_subnet_ids

  tags = {
    Name = "${var.vpc_prefix}-DB-SUBG"
  }
}

# mariadb Parameter Group 설정
resource "aws_db_parameter_group" "mariadb_parameter" {
  name        = "mariadb-parameter"
  family      = "mariadb10.11" # 사용 중인 MariaDB 버전에 맞게 조정
  description = "Custom parameter group for MariaDB"

  parameter {
    name  = "max_connections"
    value = "150"
  }

  parameter {
    name  = "time_zone"
    value = "Asia/Seoul"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_connection"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_filesystem"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_results"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "collation_connection"
    value = "utf8mb4_unicode_ci"
  }

  parameter {
    name  = "collation_server"
    value = "utf8mb4_unicode_ci"
  }


  parameter {
    name  = "binlog_format"
    value = "ROW"
  }
}

# DB 구성 (RDS 이름: 소문자로 시작해야)
resource "aws_db_instance" "rds_master" {
  identifier_prefix      = "rds-master"
  allocated_storage      = 10
  engine                 = "mariadb"
  engine_version         = "10.11.8"
  instance_class         = "db.t3.micro"
  db_name                = "initdb"
  username               = "boss"
  password               = "sd12!fg34"
  parameter_group_name   = aws_db_parameter_group.mariadb_parameter.name
  skip_final_snapshot    = true
  multi_az               = true
  db_subnet_group_name   = aws_db_subnet_group.DB_SUBG.name
  vpc_security_group_ids = [var.rds_sg_id]

  tags = {
    Name = "${var.vpc_prefix}-rds-master"
  }
}
