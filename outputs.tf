output "queue_arn" {
  value = aws_sqs_queue.this.arn
}

output "queue_url" {
  value = aws_sqs_queue.this.url
}

output "queue_name" {
  value = aws_sqs_queue.this.name
}

output "queue_id" {
  value = aws_sqs_queue.this.id
}

output "dlq_arn" {
  value = aws_sqs_queue.dlq.name
}

output "dlq_url" {
  value = aws_sqs_queue.dlq.url
}

output "dlq_name" {
  value = aws_sqs_queue.dlq.name
}
