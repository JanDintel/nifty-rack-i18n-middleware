require 'spec_helper'
require 'uri'
require 'net/http'
require 'json'

RSpec.describe 'Locale in headers' do
  let(:location)  { 'http://localhost:4567/' }
  let(:uri)       { URI.parse(location) }
  let(:http)      { Net::HTTP.new(uri.host, uri.port) }
  let(:request)   { Net::HTTP::Get.new(uri.request_uri) }

  let(:default_locale) { 'en' }
  let(:current_locale) do
    response = http.request(request)
    if response.code == '200'
      JSON.parse(response.body)['current_locale']
    else
      nil
    end
  end

  describe 'HTTP header "HTTP_X_LOCALE"' do
    before do
      request['HTTP_X_LOCALE'] = locale
    end

    context 'with the available locale "nl"' do
      let(:locale) { 'nl' }

      it 'sets the current locale to "nl"' do
        expect(current_locale).to eql locale
      end
    end

    context 'with the available locale "de"' do
      let(:locale) { 'de' }

      it 'sets the current locale to "nl"' do
        expect(current_locale).to eql locale
      end
    end

    context 'with the unavailable locale "es"' do
      let(:locale) { 'es' }

      it 'sets the current locale to the default locale "en"' do
        expect(current_locale).to eql default_locale
      end
    end
  end

  describe 'HTTP header "X_LOCALE"' do

  end

end
