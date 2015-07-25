require 'rails_helper'

describe Participant do
  it { should belong_to :year }
  it { should have_many :secret_santa }
end
