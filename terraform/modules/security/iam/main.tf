resource "aws_iam_group" "group" {
    name = "${var.group_name}"
}

resource "aws_iam_group_policy" "policy" {
    name   = "${var.group_name}"
    group  = "${aws_iam_group.group.id}"
    policy = "${var.policy}"
}

resource "aws_iam_user" "user" {
    count = "${length(var.users)}"
    name  = "${element(var.users, count.index)}"
}

resource "aws_iam_access_key" "key" {
    count = "${length(var.users)}"
    user = "${element(aws_iam_user.user.*.name, count.index)}"
}

resource "aws_iam_group_membership" "membership" {
    name = "${var.group_name}"
    group = "${aws_iam_group.group.name}"
    users = ["${aws_iam_user.user.*.name}"]
}
