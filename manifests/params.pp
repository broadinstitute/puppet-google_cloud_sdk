class google_cloud_sdk::params {
  case $::kernel {
    'linux': {
       $download_filename = 'google-cloud-sdk.tar.gz'
       $download_source = "https://dl.google.com/dl/cloudsdk/release/${download_filename}"
       $install_dir = '/opt'
     }
     default: {fail("Kernel ${::kernel} not supported by module!")}
  }
}
