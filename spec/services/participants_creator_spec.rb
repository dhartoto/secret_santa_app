require 'rails_helper'

describe ParticipantsCreator do
  let(:year) { Fabricate(:year, year: 2015) }

  before { FileUploader.upload(mock_file(file_name: 'participants.csv',
   type: 'text/csv'), 2015) }
  after { File.delete('public/uploads/participants.csv') }

  describe '.create' do
    it { should be_an_instance_of(ParticipantsCreator) }
  end

  it 'saves participants from file' do
    ParticipantsCreator.create(year)
    expect(Participant.count).to eq(5)
  end
  it 'saves participants full name' do
    ParticipantsCreator.create(year)
    expect(Participant.first.full_name).to eq('Homer Simpson')
  end
  it 'saves participants partners full name' do
    ParticipantsCreator.create(year)
    expect(Participant.first.full_name).to eq('Marge Simpson')
  end
end
