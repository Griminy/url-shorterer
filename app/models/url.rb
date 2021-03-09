class Url <  ApplicationRecord

  has_many :requests, dependent: :destroy
  validates :long, :short, uniqueness: true, presence: true
  after_initialize :set_short, if: -> { short.blank? }
  before_save :format_long

  def format_long
    UrlFormatterService.run! url: self.long
  end

  def generate_uniq_short
    UniqShortGeneratorService.run! scope: Url.where.not(id: self.id)
  end

  def set_short
    self.short = generate_uniq_short
  end

  def requested! request: nil
    Url.transaction do
      begin
        self.update! request_count: self.request_count + 1

        if request.present?
          info = [request.headers['User-Agent'], request.headers['Accept-Language']].reject(&:blank?).join(", ")
          self.requests.create! ip: request.remote_ip, info: info
        end
      rescue Exception => e
        ActiveRecord::Rollback
        raise e
      end
    end
  end

  def full_long_url
    "http://#{long}"
  end

end