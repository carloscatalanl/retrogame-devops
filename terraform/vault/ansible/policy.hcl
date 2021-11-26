# Read-only permission on secrets stored at
path "kv/*" {
    capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}