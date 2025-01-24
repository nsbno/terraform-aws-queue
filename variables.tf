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

  type    = number
  default = null
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

variable "filter_policy" {
  description = "JSON String with the filter policy that will be used in the subscription to filter messages."
  type        = string
  default     = null
}

variable "raw_message_delivery" {
  description = "Should raw message delivery be enabled, defaults to false."
  type        = bool
  default     = false
}

variable "long_poll_time_seconds" {
  description = "The amount of time a call to RecieveMessage will wait for a message before returning. Meaning that the ReceiveMessage call will perform long polling."
  type        = number
  default     = 0
}

variable "message_retention_seconds" {
  description = "The number of seconds Amazon SQS retains a message."
  type        = number
  default     = null
}
