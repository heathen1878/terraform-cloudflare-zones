variable "zones" {
  description = "A map of zones and associated accounts."
  type = map(object(
    {
      account_id       = string
      zone             = string
      jump_start       = bool
      paused           = bool
      plan             = string
      type             = string
      always_use_https = optional(string, "on")
      ssl              = optional(string, "strict")
      min_tls_version  = optional(string, "1.2")
    }
  ))
}