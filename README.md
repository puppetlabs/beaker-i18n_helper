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
    change_locale_on(host, "ja_JP.utf-8")
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

Takes in a string, `lang`, and sets $LANG, $LANGUAGE, and $LC_ALL on the target host to `#{lang}`. We **strongly** recommend appending ".utf-8" to your `lang` string.

e.g.

```ruby
change_locale_on(host, "en_GB.utf-8")
```

## Limitations

So far, this helper has only been tested for use with Debian and RedHat hosts.

Full disclosure: changing the locale only uses global environment variables. Because the Beaker function I used is additive, it's only good for setting the locale to another language and then back to English **once**. At least that's all we've tested it with. Hopefully some day that will change. See the Development section.

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

Bug reports and pull requests are welcome on GitHub at https://github.com/eputnam/beaker-i18n_helper.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
