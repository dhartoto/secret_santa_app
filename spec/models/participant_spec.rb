require 'rails_helper'

describe Participant do
  it { should belong_to :year }
  it { should have_many :secret_santa }

  describe '#current_secret_santa' do
    it 'returns the most recent secret santa for participant' do
      homer = Fabricate(:participant, full_name: 'Homer Simpson')
      year_id = 1
      5.times do
        Fabricate(:secret_santa, participant: homer, year_id: year_id)
        year_id += 1
      end
      secret_santa = SecretSanta.last.full_name
      expect(homer.current_secret_santa).to eq(secret_santa)
    end
  end
end
