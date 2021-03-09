class UrlFormatterService < ActiveInteraction::Base

  string :url

  def execute
    res = url.dup.strip
    
    res.downcase.gsub /(https?:\/\/)|(www\.)/, ""
  end

end

