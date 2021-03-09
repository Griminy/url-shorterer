class UrlsController < ApplicationController

  include Concerns::UrlHelpers
  
  def create
    long_url = params[:url]
    return api_error 'url is blank' if long_url.blank?

    formatted_url = UrlFormatterService.run! url: long_url
    url = Url.find_or_initialize_by long: formatted_url
    
    url.save! unless url.persisted?
    api_success result: short_url_for(url)
  rescue StandardError => e
    api_error "Ошибка: #{e}"
  end

  def show
    short_url = params[:id]
    url = Url.find_by_short short_url

    if url.present?
      url.requested! request: request
      api_success result: url.reload.full_long_url
    else
      api_error 'Url not found'
    end
  end

end