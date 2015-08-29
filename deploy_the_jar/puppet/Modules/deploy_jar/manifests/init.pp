class deploy_jar
{
  if $::facts['operatingsystemmajrelease'] == '7' {
    service { 'firewalld':
        ensure => 'stopped',
        before => Package['java'],
    }
  }
  elsif $::facts['operatingsystemmajrelease'] == '6'{
    service { 'iptables':
        ensure => 'stopped',
        before => Package['java'],
    }
  }
  elsif $::facts['operatingsystemmajrelease'] == '5'{
    exec { 'stop iptables':
        command => "/etc/init.d/iptables stop",  
        before => Package['java'],
    }
  }
  package { 'java':
        ensure => 'installed',
        before => Exec['download_jar'] 
      }
  exec {'downlaod_jar':
  command => "sudo /usr/bin/wget https://s3-ap-southeast-2.amazonaws.com/covata-robertbartlett-content-objectdata/spring-boot-sample-jetty-1.0.0.RC5.jar",
  before => Exec ['run_jar']
  }
  exec {'run_jar':
  command => "/bin/java -jar spring-boot-sample-jetty-1.0.0.RC5.jar", 
  }
}


