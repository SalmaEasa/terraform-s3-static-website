resource "aws_s3_bucket" "s3bucketv1" {
    bucket = var.bucketname

  }
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.s3bucketv1.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.s3bucketv1.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.s3bucketv1.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "s3_bucket" {
  bucket = aws_s3_bucket.s3bucketv1.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.s3bucketv1.arn,
          "${aws_s3_bucket.s3bucketv1.arn}/*",
        ]
      },
    ]
  })
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.s3bucketv1.id
  key    = "index.html"
  source = "index.html"
  acl = "public-read"
  content_type = "text/html"
  # This line forces an update when the file content changes
  etag = filemd5("index.html")
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.s3bucketv1.id
  key    = "error.html"
  source = "error.html"
  acl = "public-read"
  content_type = "text/html"
  # This line forces an update when the file content changes
  etag = filemd5("index.html")
}
resource "aws_s3_object" "picture" {
  bucket = aws_s3_bucket.s3bucketv1.id
  key    = "picture.jpeg"
  source = "picture.jpeg"
  acl = "public-read"
  content_type = "image/jpeg" # Change jpg to jpeg
  etag = filemd5("picture.jpeg") # Ensures it updates if you swap the file
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.s3bucketv1.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
  depends_on = [ aws_s3_bucket_acl.example ]

}