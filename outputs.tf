output "zones" {
  value = {
    zone      = cloudflare_zone.zone
    overrides = cloudflare_zone_settings_override.zone
  }
}