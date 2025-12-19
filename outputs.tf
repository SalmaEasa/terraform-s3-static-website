output "arn" {
  description = "ARN of the bucket"
  value       = aws_s3_bucket.s3bucketv1.arn
}

output "name" {
  description = "Name (id) of the bucket"
  value       = aws_s3_bucket.s3bucketv1.id
}
output "domain" {
  description = "Domain name of the bucket"
  value       = aws_s3_bucket_website_configuration.website.website_domain
}

output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.website.website_endpoint
}