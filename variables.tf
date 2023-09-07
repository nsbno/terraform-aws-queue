variable "name" {
  description = "The name of the queue"

  type = string
}

variable "is_fifo" {
  description = "Should the queue be created as a FIFO queue?"

  type    = bool
  default = false
}

variable "visibility_timeout" {
  description = "How long should the message be hidden from other consumers?"

  type = number
}

variable "max_tries_before_sending_to_dlq" {
  description = "How many times should the message be retried before sending it to the DLQ?"

  type    = number
  default = 3
}

variable "subscribe_sns_arns" {
  description = "A list of SNS ARNs to subscribe to the queue"

  type    = list(string)
  default = []
}
