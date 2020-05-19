provider "rabbitmq" {
  endpoint = var.rabbitmq_hostname
  username = var.rabbitmq_username
  password = var.rabbitmq_password
}

resource "rabbitmq_vhost" "test" {
  name = "test"
}

resource "rabbitmq_permissions" "guest" {
  user  = "guest"
  vhost = "${rabbitmq_vhost.test.name}"

  permissions {
    configure = ".*"
    write     = ".*"
    read      = ".*"
  }
}

resource "rabbitmq_queue" "hello" {
  name  = "hello"
  vhost = "${rabbitmq_permissions.guest.vhost}"

  settings {
    durable     = false
    auto_delete = true
  }
}

resource "rabbitmq_queue" "production" {
  name  = "production"
  vhost = "${rabbitmq_permissions.guest.vhost}"

  settings {
    durable     = true
    auto_delete = false
  }
}
