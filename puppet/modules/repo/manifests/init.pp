##############################################################################
# Configure repos
##############################################################################

class repo {

# Disable upstream Repos that get installed by centos-release, scientific-release packages
case $::operatingsystemrelease {
    # EL5
    /^5.*/: {
        file {
            '/etc/yum.repos.d/CentOS-Base.repo':
                ensure => absent;
            '/etc/yum.repos.d/CentOS-Debuginfo.repo':
                ensure => absent;
            '/etc/yum.repos.d/CentOS-Media.repo':
                ensure => absent;
            '/etc/yum.repos.d/CentOS-Vault.repo':
                ensure => absent;
            '/etc/yum.repos.d/cobbler-config.repo':
                ensure => absent;
        }
    }


    # EL6
    /^6.*/: {
        file {
            '/etc/yum.repos.d/sl.repo':
                ensure => absent;
            '/etc/yum.repos.d/cobbler-config.repo':
                ensure => absent;
        }
    }
    default: { }
  }
}
