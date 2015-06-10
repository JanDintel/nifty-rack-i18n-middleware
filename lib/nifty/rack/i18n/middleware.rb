require 'nifty/rack/i18n/middleware/version'

module Nifty
  module Rack
    module I18n
      class Middleware

        def initialize(app)
          @app = app
        end

        def call(env)
          begin
            set_locale(extract_locales(env))

            @app.call(env)
          ensure
            clear_locale
          end
        end

        private

        def extract_locales(env)
          request = ::Rack::Request.new(env)

          [request.params['locale'], env['HTTP_X_LOCALE'], env['HTTP_HTTP_X_LOCALE']]
        end

        def set_locale(*locales)
          filter = ->(unfiltered_locale) { unfiltered_locale if ::I18n.available_locales.map(&:to_s).include?(unfiltered_locale.to_s) }
          filtered_locale = locales.flatten.find { |locale| filter.call(locale) }

          ::I18n.locale = filtered_locale || ::I18n.default_locale
        end

        def clear_locale
          ::I18n.locale = ::I18n.default_locale
        end

      end
    end
  end
end
