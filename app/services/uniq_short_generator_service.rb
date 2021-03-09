class UniqShortGeneratorService < ActiveInteraction::Base

  object :scope, class: ::ActiveRecord::Relation, default: ::Url.all

  def execute
    res = generate
    
    if scope.where(short: res).present?
      # TODO case when all urls of this length were taken
      res = generate
    end

    res
  end

  private

  # INFo length = length * 2
  def generate
    SecureRandom.hex 2
  end

end