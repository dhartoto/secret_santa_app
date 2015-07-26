require 'rails_helper'

describe SecretSanta do
  it { should belong_to :year }
  it { should belong_to :participant }

  describe '#last_year' do
    let(:wilma) { Fabricate(:participant, full_name: 'Wilma Flintstone') }

    context 'when last year secret santa exist' do
      it 'should return secret santa for previous year' do
        last_year = Fabricate(:secret_santa, participant: wilma,
          full_name: 'Homer Simpson', year_id: 1)
        secret_santa = Fabricate(:secret_santa, participant: wilma,
          full_name: 'Marge Simpson', year_id: 2)
        expect(secret_santa.last_year).to eq(last_year)
      end
    end
    context 'when last year secret santa does not exist' do
      it 'should return nil' do
        secret_santa = Fabricate(:secret_santa, participant: wilma,
          full_name: 'Homer Simpson', year_id: 2)
        expect(secret_santa.last_year).to eq(nil)
      end
    end
  end
end
