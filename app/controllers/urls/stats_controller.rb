class Urls::StatsController < ApplicationController
  
  def index
    short_url = params[:url_id]
    url = Url.find_by_short short_url

    if url.present?
      api_success result: url.attributes
    else
      api_error 'Url not found'
    end
  end

end