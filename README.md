# Beaker::I18nHelper

This gem provides some helper methods for testing i18n and l10n with Beaker.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'beaker-i18n_helper'
```

Or install it yourself as:

    $ gem install beaker-i18n_helper

## Usage

In your spec_helper_acceptance, you may use it like:

```ruby

c.before :suite do
  hosts.each do |host|
    # Required for binding tests.
    if fact('osfamily') == 'Debian'
      #install language pack on debian systems
      install_language_pack_on(host, "ja_JP")
    end
    if fact('osfamily') == 'RedHat'
      if fact('operatingsystemmajrelease') =~ /7/ || fact('operatingsystem') =~ /Fedora/
        shell("yum install -y bzip2")
      end
    end
    #set language
    change_locale_on(host, "ja_JP")
    on host, puppet('module', 'install', 'stahnma/epel')
  end
end

```

## Reference

#### install_language_pack_on(host, lang)

Uses Beaker's `install_package` to install a language pack for the desired language. 

e.g.

```ruby
install_language_pack_on(host, 'ja_JP')
```

```ruby
install_language_pack_on(host, 'de_DE.utf8')
```
Usually only needed for Debian systems, RHEL installs all language packs by default.

#### change_locale_on(host, lang)

Changes the system local on a given unix host or hosts. Takes in a language string also and sets LANG and LANGUAGE on the target host to `#{lang}.utf8`.

e.g.

```ruby
change_locale_on(host, "en_GB")
```

## Development

PRs welcome!

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eputnam/beaker-i18n_helper.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
