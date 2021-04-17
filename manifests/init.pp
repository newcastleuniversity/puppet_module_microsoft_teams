# @summary Teams client installer
#
# @example
#   include teams

class teams {
  case $facts['osfamily'] {
    'Debian': {
      case $facts['architecture'] {
        'amd64': {

          apt::key { 'microsoft':
            id     => 'BC528686B50D79E339D3721CEB3E94ADBE1229CF',
            source => 'https://packages.microsoft.com/keys/microsoft.asc',
          }

          apt::source { 'teams':
            location     => 'https://packages.microsoft.com/repos/ms-teams',
            architecture => 'amd64',
            release      => 'stable',
            repos        => 'main',
          }

          ~> package { 'teams':
            ensure  => installed,
            require => Apt::Source['teams'],
          }

        }
        default: {
          notify { 'Unsupported architecture': }
        }
      }
    }
    default: {
      notify { 'Unsupported OS': }
    }
  }
}
