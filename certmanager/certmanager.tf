

###########################
## Data Sources
###########################
data "aws_route53_zone" "apps_zone" {
  name         = var.dns_hosted_zone_name
}

###########################
## Resources 
###########################

resource "kubernetes_namespace" "certmanager" {
  metadata {
    name = "cert-manager"

    labels = {
      "certmanager.k8s.io/disable-validation" = true
    }
  }
}

output "ns" {
  value = kubernetes_namespace.certmanager.metadata[0].name
}

resource "kubernetes_secret" "aws_secret" {
  metadata {
    name = var.secret_key_name
    namespace = kubernetes_namespace.certmanager.metadata[0].name
  }

  data = {
    aws_secret = var.aws_secret_access_key
  }
}



data "template_file" "issuer_config" {
  template = file("${path.module}/templates/cluster-issuer.yml")

  vars = {
    acme_email             = var.acme_email
    namespace             = kubernetes_namespace.certmanager.metadata[0].name
    secret_key_name       = var.secret_key_name
    aws_region            = var.aws_region
    dns_zone_name         = var.dns_hosted_zone_name
    aws_access_key_id     = var.aws_access_key_id
    aws_secret_access_key = var.aws_secret_access_key
    hosted_zone_id        = data.aws_route53_zone.apps_zone.id
  }
}



resource "k14s_kapp" "clusterissuer" {
  app           = "certmanager-cluster-issuer"
  namespace     = "default"
  config_yaml   = data.template_file.issuer_config.rendered 
  diff_changes  = false

  deploy {
    raw_options = ["--dangerous-allow-empty-list-of-resources=true"]
  }

  depends_on = [
    kubernetes_secret.aws_secret,
    helm_release.certmanager
  ]
}

resource "helm_release" "certmanager" {

  name       = "certifier"
  namespace  = kubernetes_namespace.certmanager.metadata[0].name
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v0.15.0"

  set {
    name = "installCRDs"
    value = true
  }

  set {
    name  = "ingressShim.defaultIssuerName"
    value = "letsencrypt-prod"
  }

  set {
    name  = "ingressShim.defaultIssuerKind"
    value = "ClusterIssuer"
  }

}