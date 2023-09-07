moved {
  from = aws_sqs_queue.sqs_queue
  to   = aws_sqs_queue.this
}

moved {
  from = aws_sqs_queue.sqs_queue_dlq
  to   = aws_sqs_queue.dlq
}
