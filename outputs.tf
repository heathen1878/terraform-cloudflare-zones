output "zones" {
  value = {
    zone           = cloudflare_zone.zone
    overrides      = cloudflare_zone_settings_override.zone
    zone_total_tls = cloudflare_total_tls.zone_total_tls
  }
}