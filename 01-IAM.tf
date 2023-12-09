#                                                                                                  Create Users
#                                                                                                  inst.local_id => inst *** necessary so that changes to the spreadsheet don't result in destruction/creation for EVERY change
resource "aws_iam_user" "create-users" {
  for_each  = { for my_users in local.my_users : my_users.local_id => my_users} 
      name  = each.value.user-name
      tags  = {
        (each.value.tagkey1) = (each.value.tagvalue1)
      }
}

#                                                                                                  Create User Groups
resource "aws_iam_group" "create-user-groups" {
  for_each  = { for my_groups in local.my_groups : my_groups.local_id => my_groups}
      name  = each.value.user-group
      path  = "/user/"
  }

#                                                                                                  Group Memberships - what groups are the users in
resource "aws_iam_group_membership" "group-memberships" {
  for_each  = { for users-count in local.my_users : users-count.local_id => users-count}
      name  = each.value.user-grp
      users = [each.value.user-name]
      group = each.value.user-grp
  }