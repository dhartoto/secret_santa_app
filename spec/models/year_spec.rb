require 'rails_helper'

describe Year do
  it { should have_many :participants }
  it { should have_many :secret_santa }
end
