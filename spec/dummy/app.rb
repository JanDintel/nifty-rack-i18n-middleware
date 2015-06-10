require_relative './config/environment'
require 'sinatra'
require 'nifty/rack/i18n/middleware'

use Rack::Lint
use Nifty::Rack::I18n::Middleware

get '/' do
  JSON.generate({ current_locale: I18n.locale.to_s, message: I18n.t('hello_world') })
end
