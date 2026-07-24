data "aws_region" "requester" {
  provider = aws.requester
}

data "aws_region" "accepter" {
  provider = aws.accepter
}