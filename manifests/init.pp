# @summary Teams client installer
#
# @example
#   include teams

class teams (
  $source   = 'puppet:///modules/teams/teams_1.2.00.32451_amd64.deb',
  $filename = 'teams_1.2.00.32451_amd64.deb'
){
  case $facts['osfamily'] {
    'Debian': {
      case $facts['architecture'] {
        'amd64': {
          file { 'teams.deb':
            ensure         => file,
            path           => "/var/cache/apt/archives/${filename}",
            source         => $source,
            checksum       => 'sha256',
            checksum_value => '28d8a0e644a4bb9d4ee9295953b97b7fa6558b8a9d1d28363a594f5cde1c05dc',
          }
          package { 'teams':
            ensure   => installed,
            provider => 'dpkg',
            source   => "/var/cache/apt/archives/${filename}",
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
