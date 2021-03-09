module Concerns::UrlHelpers

  extend ActiveSupport::Concern

  def short_url_for record
    urls_url url: record.short
  end

end