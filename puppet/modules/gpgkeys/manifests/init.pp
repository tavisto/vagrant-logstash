# module to pull down GPG keys for non-OS repos to nodes
#

class gpgkeys {

    # Install EPEL GPG keys for our EL version
    include epel

    # Install remi gpg keys
    include remi

    # Istall RPMfusion GPG keys for our EL version
    include rpmfusion

    # Install Puppet GPG keys
    include puppet

    # Install the Spacewalk GPG keys for our EL version
    include spacewalk

}