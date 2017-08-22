require 'beaker'

module Beaker::I18nHelper
  include Beaker::DSL
  include Beaker::DSL::Helpers::FacterHelpers

  def install_language_pack(hsts, lang)

    if lang.match(/\.\w$/)
      lang = lang.split(".")[0]
    end

    if lang.match(/_/)
      lang = lang.split("_")
    elsif lang.match(/-/)
      lang = lang.split("-")
    end

    Array(hsts).each do |host|
      if fact_on(host, "osfamily") == 'Debian'
        install_package(host, "language-pack-#{lang[0]}")
      end
    end
  end

  def change_locale_on(hsts, lang)
    Array(hsts).each do |host|
      on(host, "localectl set-locale LANG=#{lang}.utf8")
      on(host, "export LANGUAGE=#{lang}.utf8")
    end
  end
end

include Beaker::I18nHelper
