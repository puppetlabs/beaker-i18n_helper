require 'beaker'

# Beaker i18n Helper
module Beaker::I18nHelper # rubocop:disable Style/ClassAndModuleChildren
  include Beaker::DSL
  include Beaker::DSL::Helpers::FacterHelpers

  # Validates POSIX locale identifier format
  #
  # @param lang [String] the identifier as a string, e.g. 'ja_JP.utf8'
  # @return [Boolean] true if it's a valid identifier
  #
  def valid_lang_string?(lang)
    lang_regex = %r{^[a-zA-Z][a-zA-Z](\_|\-)[a-zA-Z][a-zA-Z](\..*)?$}
    raise "Please use correct format for lang: #{lang_regex}" unless lang.match lang_regex
    true
  end

  # Parses a given POSIX locale identifier into parts for the other functions to consume
  #
  # @param lang [String] the identifier as a string, e.g. 'ja_JP.utf8'
  # @return [Array] the identifier as an array of [{lang},{region},{charset}]
  #
  def parse_lang(lang)
    lang = lang.split('.')[0] if lang =~ %r{\.\S}

    if lang =~ %r{_}
      lang = lang.split('_')
    elsif lang =~ %r{-}
      lang = lang.split('-')
    end

    lang
  end

  # Installs the language pack on each host for a given language (if necessary)
  #
  # @param hsts [Array] beaker hosts array
  # @param lang [String] the POSIX locale identifier as a string, e.g. 'ja_JP.utf8'
  # @return [nil]
  #
  def install_language_on(hsts, lang)
    valid_lang_string?(lang)
    lang = parse_lang(lang)

    Array(hsts).each do |host|
      begin
        case fact('operatingsystem')
        when 'Debian'
          install_locales_all_on(host)
        when 'Ubuntu'
          install_language_pack_on(host, lang)
        end
      rescue RuntimeError
        raise "Unable to install language pack for #{lang[0]} on #{host}"
      end
    end
  end

  # Changes the locale on each host to the given language
  #
  # @param hsts [Array] beaker hosts array
  # @param lang [String] the POSIX locale identifier as a string, e.g. 'ja_JP.utf8'
  # @return [nil]
  #
  def change_locale_on(hsts, lang)
    valid_lang_string?(lang)
    Array(hsts).each do |host|
      begin
        host.clear_env_var('LANG')
        host.add_env_var('LANG', lang)
        host.clear_env_var('LANGUAGE')
        host.add_env_var('LANGUAGE', lang)
      rescue RuntimeError
        raise "Unable to change locale to #{lang} on #{host}"
      end
    end
  end

  private

  # Installs the 'locales-all' package on the target host unless it is already installed
  #
  # @param host [Beaker::Host] beaker host
  # @return [nil]
  #
  def install_locales_all_on(host)
    install_package(host, 'locales-all') unless check_for_package(host, 'locales-all')
  end

  # Installs the language pack on the target host for a given language (if necessary)
  #
  # @param host [Beaker::Host] beaker host
  # @param lang [String] the POSIX locale identifier as a string, e.g. 'ja_JP.utf8'
  # @return [nil]
  #
  def install_language_pack_on(host, lang)
    install_package(host, "language-pack-#{lang[0]}")
    install_package(host, 'systemd-services') unless shell('file /sbin/init').stdout =~ %r{systemd}
  end
end

include Beaker::I18nHelper
