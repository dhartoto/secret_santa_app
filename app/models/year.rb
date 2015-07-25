class Year < ActiveRecord::Base
  has_many :participants
  has_many :secret_santa, class_name: 'SecretSanta'
end
