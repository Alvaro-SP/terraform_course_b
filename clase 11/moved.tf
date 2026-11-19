
moved {
  from = aws_s3_bucket.logs
  to   = module.logs_bucket.aws_s3_bucket.this
}

moved {
  from = aws_s3_bucket_public_access_block.logs
  to   = module.logs_bucket.aws_s3_bucket_public_access_block.this
}

moved {
  from = aws_s3_bucket.data
  to   = module.data_bucket.aws_s3_bucket.this
}

moved {
  from = aws_s3_bucket_public_access_block.data
  to   = module.data_bucket.aws_s3_bucket_public_access_block.this
}
