class Year < ActiveRecord::Base
  has_many :participants
  has_many :secret_santa, dependent: :destroy, class_name: 'SecretSanta'
end
