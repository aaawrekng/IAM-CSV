locals {
    my_groups  = csvdecode(file("User-Groups.csv"))
    my_users   = csvdecode(file("Users.csv"))
}
