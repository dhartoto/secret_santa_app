class SecretSanta < ActiveRecord::Base
  belongs_to :year
  belongs_to :participant
end
