require 'i18n'

I18n.config.load_path += Dir[File.join(File.expand_path('../', __FILE__), 'locales', '*.{rb,yml}')]
I18n.config.available_locales = [:en, :nl, :de]
I18n.config.default_locale = :en
