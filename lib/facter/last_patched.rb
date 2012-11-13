# last_patched.rb

Facter.add("last_patched") do
    setcode do
        family = Facter.value("osfamily")
        case family
        when /Suse|RedHat/
            command = "rpm -qa --queryformat '%{installtime}\\n' | sort -n | tail -1"
            timestamp = Facter::Util::Resolution.exec(command).chomp()
            Time.at(Integer(timestamp)).iso8601
        when /Debian/
            #This command shamelessly taken from some example, looking for a better way to do this.
            command = "ls --time-style='+%s' -l /var/log/apt | awk '{print $6}' | sort -u | tail -1"
            timestamp = Facter::Util::Resolution.exec(command).chomp()
            Time.at(Integer(timestamp)).iso8601
        else
            "%s is not Supported." % Facter.value("osfamily")
        end
    end
end
