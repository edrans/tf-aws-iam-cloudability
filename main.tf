resource "aws_iam_role" "cloudability" {
  name               = "${var.role_name}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "arn:aws:iam::${var.trusted_account_id}:user/cloudability"
      },
      "Effect": "Allow",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "${var.external_id}"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "cloudability_monitor_resources" {
  name = "CloudabilityMonitorResourcesPolicy"
  role = "${aws_iam_role.cloudability.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "iam:SimulatePrincipalPolicy",
        "cloudwatch:GetMetricStatistics",
        "dynamodb:DescribeTable",
        "dynamodb:ListTables",
        "ec2:DescribeImages",
        "ec2:DescribeInstances",
        "ec2:DescribeRegions",
        "ec2:DescribeReservedInstances",
        "ec2:DescribeReservedInstancesModifications",
        "ec2:DescribeSnapshots",
        "ec2:DescribeVolumes",
        "ecs:DescribeClusters",
        "ecs:DescribeContainerInstances",
        "ecs:ListClusters",
        "ecs:ListContainerInstances",
        "elasticache:DescribeCacheClusters",
        "elasticache:DescribeReservedCacheNodes",
        "elasticache:ListTagsForResource",
        "elasticmapreduce:DescribeCluster",
        "elasticmapreduce:ListClusters",
        "elasticmapreduce:ListInstances",
        "rds:DescribeDBClusters",
        "rds:DescribeDBInstances",
        "rds:DescribeReservedDBInstances",
        "rds:ListTagsForResource",
        "redshift:DescribeClusters",
        "redshift:DescribeReservedNodes",
        "redshift:DescribeTags"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
