resource "aws_dynamodb_table" "dynamo_db" {
  name         = "dynamo_db_table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    name = "dynamo_db_table"
  }
}