node web {
  notify{"Hello from ${::fqdn}":}
}