require 'rails_helper'

describe SecretSanta do
  it { should belong_to :year }
  it { should belong_to :participant }
end
