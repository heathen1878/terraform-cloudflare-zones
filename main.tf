resource "cloudflare_zone" "zone" {
  for_each = var.zones

  account_id = each.value.account_id
  zone       = each.value.zone
  jump_start = each.value.jump_start
  paused     = each.value.paused
  plan       = each.value.plan
  type       = each.value.type
}

resource "cloudflare_zone_settings_override" "zone" {
  for_each = var.zones

  zone_id = cloudflare_zone.zone[each.key].id

  settings {
    always_online               = "off"
    always_use_https            = each.value.always_use_https
    automatic_https_rewrites    = "on"
    binary_ast                  = "off"
    brotli                      = "on"
    browser_cache_ttl           = 14400
    browser_check               = "on"
    cache_level                 = "aggressive"
    challenge_ttl               = 1800
    ciphers                     = []
    cname_flattening            = "flatten_at_root"
    development_mode            = "off"
    early_hints                 = "off"
    email_obfuscation           = "on"
    filter_logs_to_cloudflare   = each.value.plan == "free" ? null : "off"
    h2_prioritization           = "off"
    hotlink_protection          = "off"
    http2                       = each.value.plan == "free" ? null : "on"
    http3                       = "on"
    image_resizing              = each.value.plan == "free" ? null : "off"
    ip_geolocation              = "on"
    ipv6                        = "on"
    log_to_cloudflare           = each.value.plan == "free" ? null : "on"
    max_upload                  = 100
    min_tls_version             = each.value.min_tls_version
    mirage                      = each.value.plan == "free" ? null : "off"
    opportunistic_encryption    = "on"
    opportunistic_onion         = "on"
    orange_to_orange            = each.value.plan == "free" ? null : "off"
    origin_error_page_pass_thru = each.value.plan == "free" ? null : "off"
    origin_max_http_version     = "2"
    polish                      = each.value.plan == "free" ? null : "off"
    prefetch_preload            = each.value.plan == "free" ? null : "off"
    privacy_pass                = "on"
    proxy_read_timeout          = each.value.plan == "free" ? null : "100"
    pseudo_ipv4                 = "off"
    response_buffering          = each.value.plan == "free" ? null : "off"
    rocket_loader               = "off"
    security_level              = "medium"
    server_side_exclude         = "on"
    sort_query_string_for_cache = each.value.plan == "free" ? null : "off"
    ssl                         = each.value.ssl
    tls_1_2_only                = null
    tls_1_3                     = "on"
    tls_client_auth             = "off"
    true_client_ip_header       = each.value.plan == "free" ? null : "off"
    universal_ssl               = each.value.plan == "free" ? null : "on"
    visitor_ip                  = each.value.plan == "free" ? null : "on"
    waf                         = each.value.plan == "free" ? null : "off"
    webp                        = each.value.plan == "free" ? null : "off"
    websockets                  = "on"
    zero_rtt                    = "off"
  }

}

resource "cloudflare_certificate_pack" "zone" {
for_each = var.zones

  zone_id = cloudflare_zone.zone[each.key].id
  type                   = "advanced"
  hosts                  = each.value.hosts
  validation_method      = "txt"
  validity_days          = 90
  certificate_authority  = "lets_encrypt"
  cloudflare_branding    = false
  wait_for_active_status = true
}