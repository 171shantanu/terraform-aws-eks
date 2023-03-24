# Associating the public RT with the public subnet 1
resource "aws_route_table_association" "public_rt_1_assoc" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_1.id
}

# Associating the public RT with the public subnet 2
resource "aws_route_table_association" "public_rt_2_assoc" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public_1.id
}

# Associating the private RT with the private subnet 1
resource "aws_route_table_association" "private_rt_1_assoc" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_1.id
}

# Associating the private RT with the private subnet 2
resource "aws_route_table_association" "private_rt_2_assoc" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private_2.id
}
