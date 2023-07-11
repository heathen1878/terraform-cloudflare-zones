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
    filter_logs_to_cloudflare   = null
    h2_prioritization           = "off"
    hotlink_protection          = "off"
    http2                       = null
    http3                       = "on"
    image_resizing              = null
    ip_geolocation              = "on"
    ipv6                        = "on"
    log_to_cloudflare           = null
    max_upload                  = 100
    min_tls_version             = each.value.min_tls_version
    mirage                      = null
    opportunistic_encryption    = "on"
    opportunistic_onion         = "on"
    orange_to_orange            = null
    origin_error_page_pass_thru = null
    origin_max_http_version     = "2"
    polish                      = null
    prefetch_preload            = null
    privacy_pass                = "on"
    proxy_read_timeout          = null
    pseudo_ipv4                 = "off"
    response_buffering          = null
    rocket_loader               = "off"
    security_level              = "medium"
    server_side_exclude         = "on"
    sort_query_string_for_cache = null
    ssl                         = each.value.ssl
    tls_1_2_only                = null
    tls_1_3                     = "on"
    tls_client_auth             = "off"
    true_client_ip_header       = null
    universal_ssl               = each.value.plan == "free" ? null : "on"
    visitor_ip                  = null
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