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
      install_language_on(host, "ja_JP.utf-8")
    end
    if fact('osfamily') == 'RedHat'
      if fact('operatingsystemmajrelease') =~ /7/ || fact('operatingsystem') =~ /Fedora/
        shell("yum install -y bzip2")
      end
    end
    #set language
    change_locale_on(host, "ja_JP.utf-8")
    on host, puppet('module', 'install', 'stahnma/epel')
  end
end

```

## Reference

#### install_language_on(hosts, lang)

Uses Beaker's `install_package` to install a language pack for the desired language. Takes a hosts array and `lang`, a POSIX locale identifier ([lang]_[region].[charset])

```ruby
install_language_on(hosts, 'ja_JP.utf-8')
```
Usually only needed for Debian systems, RHEL installs all language packs by default.

#### change_locale_on(hosts, lang)

Takes in a POSIX locale identifier, `lang`, and sets $LANG, $LANGUAGE, and on the target hosts to `#{lang}`.

```ruby
change_locale_on(hosts, "de_DE.utf-8")
```

## Limitations

So far, this helper has only been tested for use with Debian and RedHat hosts.

## Development

PRs welcome!

### Testing

#### Unit tests
You can run unit tests with rspec
```shell
$ rspec spec/beaker/i18n_helper_spec.rb
```

#### Acceptance tests
You can run acceptance tests with rspec, too, plus a little Beaker sugar:
```shell
$ BEAKER_provision=yes BEAKER_set=default rspec spec/acceptance
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/puppetlabs/beaker-i18n_helper.

## License

The gem is available as open source under the terms of the [Apache 2.0 License](http://www.apache.org/licenses/LICENSE-2.0).
