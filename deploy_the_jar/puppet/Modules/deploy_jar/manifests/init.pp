class deploy_jar 
{
  $java_package = $operatingsystemmajrelease ? {
    '5' => 'java-1.6.0-openjdk'
    default:  => 'java-1.8.0-openjdk'
  }
    
   if $operatingsystemmajrelease == '7' {
    service { 'firewalld':
        ensure => 'stopped',
        before => Package[$java_package],
    }
  }
  if $operatingsystemmajrelease == '6' or $operatingsystemmajrelease == '5' {
    exec { "stop iptables":
        command => "/usr/bin/sudo /etc/init.d/iptables stop",
        before => Package[$java_package],
    }
  }
  
  package { $java_package:
        ensure => 'installed',
        before => Exec['download_jar'],
      }

  exec {'download_jar':
  command => "/usr/bin/wget https://s3-ap-southeast-2.amazonaws.com/covata-robertbartlett-content-objectdata/spring-boot-sample-jetty-1.0.0.RC5.jar",
  before => Exec ['run_jar']
 }
  exec {'run_jar':
  command => "/usr/bin/java -jar spring-boot-sample-jetty-1.0.0.RC5.jar&", 
  }
}


