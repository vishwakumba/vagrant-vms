node default {
  $role = hiera('role')
  include $role
}
