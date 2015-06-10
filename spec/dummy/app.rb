require_relative './config/environment'
require 'sinatra'

get '/' do
  JSON.generate({ current_locale: I18n.locale.to_s, message: I18n.t('hello_world') })
end
