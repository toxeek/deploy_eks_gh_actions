autoscaling_average_cpu = 30
eks_managed_node_groups = {
  "my-app-eks-x86" = {
    ami_type     = "AL2_x86_64"
    min_size     = 1
    max_size     = 16
    desired_size = 1
    instance_types = [
      "t3.small",
      "t3.medium",
      "t3.large",
      "t3a.small",
      "t3a.medium",
      "t3a.large"
    ]
    capacity_type = "SPOT"
    network_interfaces = [{
      delete_on_termination       = true
      associate_public_ip_address = true
    }]
  }
  "my-app-eks-arm" = {
    ami_type     = "AL2_ARM_64"
    min_size     = 1
    max_size     = 16
    desired_size = 1
    instance_types = [
      "c7g.medium",
      "c7g.large"
    ]
    capacity_type = "ON_DEMAND"
    network_interfaces = [{
      delete_on_termination       = true
      associate_public_ip_address = true
    }]
  }
}
cluster_name            = "my-app-eks-prod"
iac_environment_tag     = "production"
name_prefix             = "my-app"
main_network_block      = "10.2.0.0/16"
cluster_azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
subnet_prefix_extension = 4
zone_offset             = 8
spot_termination_handler_chart_name      = "aws-node-termination-handler"
spot_termination_handler_chart_repo      = "https://aws.github.io/eks-charts"
spot_termination_handler_chart_version   = "0.21.0"
spot_termination_handler_chart_namespace = "kube-system"
external_dns_iam_role      = "external-dns"
external_dns_chart_name    = "external-dns"
external_dns_chart_repo    = "https://kubernetes-sigs.github.io/external-dns/"
external_dns_chart_version = "1.9.0"

external_dns_values = {
  "image.repository"   = "registry.k8s.io/external-dns/external-dns",
  "image.tag"          = "v0.14.0",
  "logLevel"           = "info",
  "logFormat"          = "json",
  "triggerLoopOnEvent" = "true",
  "interval"           = "5m",
  "policy"             = "sync",
  "sources"            = "{ingress}"
}
admin_users     = ["thomas-gray", "ursula-williams"]
developer_users = ["melissa-oliver", "lex-oneil"]
dns_base_domain               = "eks.singh.cl"
ingress_gateway_name          = "aws-load-balancer-controller"
ingress_gateway_iam_role      = "load-balancer-controller"
ingress_gateway_chart_name    = "aws-load-balancer-controller"
ingress_gateway_chart_repo    = "https://aws.github.io/eks-charts"
ingress_gateway_chart_version = "1.4.1"
namespaces = ["sample-apps"]
eks_pod_identity_associations = {
  "sample-apps-s3-readonly" = {
    policy_arn                = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
    service_account_name      = "s3-readonly"
    service_account_namespace = "sample-apps"
  }
}
