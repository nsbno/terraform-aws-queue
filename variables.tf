variable "name" {
  description = "The name of the queue"

  type = string
  validation {
    condition     = !can(regex("\\.fifo$", var.name))
    error_message = "Use the is_fifo variable to create a FIFO queue. The names of the queue and the DLQ will be correctly postfixed with .fifo."
  }
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

variable "filter_policy_scope" {
  description = "Whether the filter policy applies to MessageAttributes or MessageBody. If not set, the default from AWS will be used."
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

variable "message_retention_seconds_dlq" {
  description = "The number of seconds Amazon SQS retains a message in the DLQ."
  type        = number
  default     = null
}

variable "deduplication_scope" {
  description = "(Optional) Specifies whether message deduplication occurs at the message group or queue level."
  type        = string
  default     = "queue"

  validation {
    condition     = contains(["queue", "messageGroup"], var.deduplication_scope)
    error_message = "Allowed values for deduplication_scope are 'queue' or 'messageGroup'."
  }
}

variable "fifo_throughput_limit" {
  description = "(Optional) Specifies whether the FIFO queue throughput quota applies to the entire queue or per message group"
  type        = string
  default     = "perQueue"

  validation {
    condition     = contains(["perQueue", "perMessageGroupId"], var.fifo_throughput_limit)
    error_message = "Allowed values for fifo_throughput_limit are 'perQueue' or 'perMessageGroupId'."
  }
}

variable "content_based_deduplication" {
  description = "(Optional) Enables content-based deduplication for FIFO queues"
  type        = bool
  default     = null
}
