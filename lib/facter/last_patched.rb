# last_patched.rb

Facter.add("last_patched") do
    setcode do
        family = Facter.value("osfamily")
        case family
        when /Suse|RedHat/
            timestamp = Facter::Util::Resolution.exec('time rpm -qa --queryformat '%{installtime}\n' | sort -n | tail -1
')
            Time.at(timestamp).to_time.iso8601
        else
            "%s is not Supported." % Facter.value("osfamily")
end
