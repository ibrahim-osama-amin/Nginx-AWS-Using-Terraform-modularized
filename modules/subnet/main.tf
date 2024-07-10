#Subnet
resource "aws_subnet" "myapp-subnet-1" {
    vpc_id = var.vpc_id
    cidr_block = var.subnet_cidr_block
    availability_zone = var.avail_zone
    tags = {
        Name = "${var.env_prefix}-subnet-1"
    }
}

#Route table
resource "aws_route_table" "myapp-route-table"{
    vpc_id = var.vpc_id

    route { 
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myapp_igw.id
    }
    tags = {
        Name: "${var.env_prefix}-rtb"
    }
}

#Internet Gateway
resource "aws_internet_gateway" "myapp_igw"{
    vpc_id = var.vpc_id
        tags = {
        Name: "${var.env_prefix}-igw"
    }
}

#Associating a subnet to the route table 
resource "aws_route_table_association" "a-rtb-subnet"{
    subnet_id = aws_subnet.myapp-subnet-1.id
    route_table_id = aws_route_table.myapp-route-table.id
}
