# Cloudflare zones

Creates one or more Cloudflare zones and returns the zone attributes for other modules to consume. You can also pass override configuration such as strict SSL and force HTTPS.

See [here](https://raw.githubusercontent.com/heathen1878/terraform-cloudflare-zones/main/terraform.tfvars.example) for an example input.

## Dependencies

Requires an API token; this can be exposed using the following environemnt variable 