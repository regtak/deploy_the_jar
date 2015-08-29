class deploy_jar 
{
#   if Facts['operatingsystemmajrelease'] == '7' {
#    service { 'firewalld':
#        ensure => 'stopped',
#        before => Package['java-1.8.0-openjdk'],
#    }
#  }
#  if Facts['operatingsystemmajrelease'] == '6' {
    exec { "stop iptables":
        command => "/usr/bin/sudo /etc/init.d/iptables stop",
        #before => Package['java-1.8.0-openjdk'],
    }
#  }
  
#  package { 'java-1.8.0-openjdk':
#        ensure => 'installed',
#        before =>  Package['wget.x86_64'],
#      }
#  package { 'wget.x86_64':
#        ensure => 'installed',
#        before => Exec['download_jar'],
#      }
      
#  exec {'download_jar':
#  command => "/usr/bin/wget https://s3-ap-southeast-2.amazonaws.com/covata-robertbartlett-content-objectdata/spring-boot-sample-jetty-1.0.0.RC5.jar",
#  before => Exec ['run_jar']
# }
#  exec {'run_jar':
#  command => "/usr/bin/java -jar spring-boot-sample-jetty-1.0.0.RC5.jar&", 
#  }
}


