# Change log

All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org).

## [1.1.0]
### Summary
This release contains a fix and a public API change.

#### Changed
- `install_language_pack_on` method is now called `install_language_on`

#### Fixed
- issue where language packs aren't available on Debian. Installs 'locales-all' instead.

## [1.0.1]
### Summary
This release fixes the `change_locale_on` method and makes some README updates.

#### Fixed
- `change_locale_on` now clears and sets environment variables, eliminating the issue where locales would stack

## [1.0.0]
### Summary
This is the first release of this gem.

[1.1.0]:https://github.com/puppetlabs/beaker-i18n_helper/compare/1.0.1...1.1.0
[1.0.1]:https://github.com/puppetlabs/beaker-i18n_helper/compare/1.0.0...1.0.1
[1.0.0]:https://github.com/puppetlabs/beaker-i18n_helper/tags/1.0.0
