output "users"       { value = "${join(",", aws_iam_access_key.key.*.user)}" }
output "access_ids"  { value = "${join(",", aws_iam_access_key.key.*.id)}" }
output "secret_keys" { value = "${join(",", aws_iam_access_key.key.*.secret)}" }
