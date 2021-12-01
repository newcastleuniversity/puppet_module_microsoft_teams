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
    'RedHat': {
      case $facts['architecture'] {
        'x86_64': {
          yumrepo { 'teams':
            baseurl  => 'https://packages.microsoft.com/yumrepos/ms-teams',
            gpgkey   => 'https://packages.microsoft.com/keys/microsoft.asc',
            descr    => 'Microsoft - Teams',
            enabled  => 1,
            gpgcheck => 1,
          }
          package { "teams":
            ensure  => latest,
            require => Yumrepo['teams'],
          }
        }
      }
    }
    default: {
      fail('The Teams installer module only works with amd64 Debian/x86_64 RHEL derivatives, your distribution is unsupported.')
    }
  }
}
