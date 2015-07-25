class Participant < ActiveRecord::Base
  belongs_to :year
  has_many :secret_santa, class_name: 'SecretSanta'
end
