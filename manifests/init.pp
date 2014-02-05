class google_cloud_sdk(
  $install_dir = $::google_cloud_sdk::params::install_dir
) inherits google_cloud_sdk::params {

  validate_absolute_path($install_dir)

  File { owner => 'root', group => 'root', mode => '0644', }  

  archive::download { $download_filename: 
    url => $download_source,
    checksum => false,
  }

  archive::extract { 'google-cloud-sdk': 
    target => $install_dir,
    require => Archive::Download[$download_filename],
  }

  exec { 'install Google Cloud SDK':
    path => ['/bin', '/sbin', '/usr/bin', '/usr/sbin'],
    creates => "${install_dir}/google-cloud-sdk/install.sh",
    cwd => "${install_dir}/google-cloud-sdk",
    command => '/bin/echo "" | ./install.sh install.sh --usage-reporting false --disable-installation-options --bash-completion false --update-rc false',
    require => Archive::Extract['google-cloud-sdk'],
  }
}
