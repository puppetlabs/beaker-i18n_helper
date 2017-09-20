require 'beaker'

# Setting up the module
module Beaker::I18nHelper # rubocop:disable Style/ClassAndModuleChildren
  include Beaker::DSL
  include Beaker::DSL::Helpers::FacterHelpers

  def valid_lang_string?(lang)
    lang_regex = %r{^[a-zA-Z][a-zA-Z](\_|\-)[a-zA-Z][a-zA-Z](\..*)?$}
    raise "Please use correct format for lang: #{lang_regex}" unless lang.match lang_regex
    true
  end

  def parse_lang(lang)
    lang = lang.split('.')[0] if lang =~ %r{\.\S}

    if lang =~ %r{_}
      lang = lang.split('_')
    elsif lang =~ %r{-}
      lang = lang.split('-')
    end

    lang
  end

  def install_language_pack_on(hsts, lang)
    valid_lang_string?(lang)
    lang = parse_lang(lang)

    Array(hsts).each do |host|
      begin
        install_package(host, 'systemd-services') unless shell('file /sbin/init').stdout =~ %r{systemd}
        install_package(host, "language-pack-#{lang[0]}")
      rescue RuntimeError
        raise "Unable to install language pack for #{lang[0]} on #{host}"
      end
    end
  end

  def change_locale_on(hsts, lang)
    valid_lang_string?(lang)
    Array(hsts).each do |host|
      begin
        host.add_env_var('LANG', lang)
        host.add_env_var('LANGUAGE', lang)
        host.add_env_var('LC_ALL', lang)
      rescue RuntimeError
        raise "Unable to change locale to #{lang} on #{host}"
      end
    end
  end
end

include Beaker::I18nHelper
