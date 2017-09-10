# This role install/configures all the required components for the rabbitmq
class role::node::rabbitmq {
  include profile::common::base
  include profile::component::rabbitmq
}
