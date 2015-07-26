class SecretSanta < ActiveRecord::Base
  belongs_to :year
  belongs_to :participant

  def last_year
    SecretSanta.find_by(year_id: (year_id - 1))
  end
end
