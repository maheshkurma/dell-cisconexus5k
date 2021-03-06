#
# The alias type supports the functionality to create and delete aliases
# on the Cisco nexus switch. 
#

Puppet::Type.newtype(:alias) do
  @doc = "Manages an alias"
  #apply_to_device
  ensurable

  newparam(:name) do
    desc "The string type alias name."
    isnamevar
    newvalues(/^\S+/)
    validate do |value|
      if value.strip.length == 0
        raise ArgumentError , "Alias name cannot be empty."
      end
    end
  end

  newproperty(:member) do
    desc "Member WWPN - supported format XX:XX:XX:XX:XX:XX:XX:XX  "
    Puppet.debug "member validation check"
    validate do |value|
      if value.strip.length == 0
        raise ArgumentError , "member name cannot be empty."
      end

      unless value  =~ /([0-9a-f]{2}:){7}[0-9a-f]{2}/
        raise ArgumentError, " member WWPN supported format XX:XX:XX:XX:XX:XX:XX:XX."
      end
    end
  end
end
