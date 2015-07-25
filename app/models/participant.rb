class Participant < ActiveRecord::Base
  belongs_to :year
  has_many :secret_santa, class_name: 'SecretSanta'

  def current_secret_santa
    secret_santa.last.full_name
  end
end
