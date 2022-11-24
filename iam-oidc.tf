data "tls_certificate" "eks" {
  url = module.my-cluster.cluster_oidc_issuer_url
  
}
