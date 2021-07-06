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
            ensure  => latest,
            require => Apt::Source['teams'],
          }

        }
        default: {
          fail('Teams only runs on AMD64, your architecture is unsupported.')
        }
      }
    }
    default: {
      fail('The Teams installer module only works with Debian derivatives, your distribution is unsupported.')
    }
  }
}
