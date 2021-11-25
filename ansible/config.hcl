disable_cache = true
disable_mlock = true
ui = true
listener "tcp" {
   address          = "127.0.0.1:8200"
   tls_disable      = 1
}
storage "file" {
   path  = "/var/lib/vault/data"
 }

api_addr         = "https://127.0.0.1:8200"
max_lease_ttl         = "10h"
default_lease_ttl    = "10h"
cluster_name         = "vault"
raw_storage_endpoint     = true
disable_sealwrap     = true
disable_printable_check = true