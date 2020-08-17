###########################
## Data Sources
###########################
data "aws_route53_zone" "main" {
  name = var.base_dns_zone #"aws.clue2solve.com" #var.dns_zone_name
}

resource "aws_route53_zone" "apps" {
  name = join(".", [var.cluster_dns_prefix,var.base_dns_zone ]) 

  tags = {
    Environment = "dev"
  }
}

resource "aws_route53_record" "dev-ns" {
  zone_id = "${data.aws_route53_zone.main.zone_id}"
  name    = aws_route53_zone.apps.name  #"apps.aws.clue2solve.com"
  type    = "NS"
  ttl     = "30"

  records = [
    "${aws_route53_zone.apps.name_servers.0}",
    "${aws_route53_zone.apps.name_servers.1}",
    "${aws_route53_zone.apps.name_servers.2}",
    "${aws_route53_zone.apps.name_servers.3}",
  ]
}




data "template_file" "dns_values_tfvars" {
  template = file("${path.module}/templates/dns-zone-vars.auto.tfvars")

  vars = {
    dns_hosted_zone_name  = aws_route53_zone.apps.name
  }
}

resource "local_file" "dns_values_tfvars" {
  
    content     = data.template_file.dns_values_tfvars.rendered
    filename    = "../dns-zone-vars.auto.tfvars"
}


output "dns_hosted_zone_name" {
  value = aws_route53_zone.apps.name
}
output "dns_hosted_zone_id" {
  value = aws_route53_zone.apps.id
}