resource "aws_sqs_queue" "this" {
  name                        = var.is_fifo ? "${var.name}.fifo" : var.name
  fifo_queue                  = var.is_fifo
  deduplication_scope         = var.deduplication_scope
  fifo_throughput_limit       = var.fifo_throughput_limit
  content_based_deduplication = var.content_based_deduplication
  visibility_timeout_seconds  = var.visibility_timeout
  sqs_managed_sse_enabled     = true
  receive_wait_time_seconds   = var.long_poll_time_seconds
  message_retention_seconds   = var.message_retention_seconds

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = var.max_tries_before_sending_to_dlq
  })
}

resource "aws_sqs_queue" "dlq" {
  name = var.is_fifo ? "${var.name}-dlq.fifo" : "${var.name}-dlq"

  fifo_queue                = var.is_fifo
  message_retention_seconds = var.message_retention_seconds_dlq
}

data "aws_iam_policy_document" "allow_sns_recieve" {
  count = length(var.subscribe_sns_arns) == 0 ? 0 : 1

  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = ["sns.amazonaws.com"]
    }

    actions = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.this.arn]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = var.subscribe_sns_arns
    }
  }
}

resource "aws_sqs_queue_policy" "allow_sns_recieve" {
  count = length(var.subscribe_sns_arns) == 0 ? 0 : 1

  queue_url = aws_sqs_queue.this.id
  policy    = data.aws_iam_policy_document.allow_sns_recieve[0].json
}

resource "aws_sns_topic_subscription" "this" {
  for_each = toset(var.subscribe_sns_arns)

  topic_arn = each.value

  protocol = "sqs"
  endpoint = aws_sqs_queue.this.arn

  raw_message_delivery = var.raw_message_delivery

  filter_policy       = var.filter_policy
  filter_policy_scope = var.filter_policy_scope
}
