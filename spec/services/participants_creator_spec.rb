require 'rails_helper'

describe ParticipantsCreator do
  let(:year) { Fabricate(:year, year: 2015) }
  let!(:file) { mock_file(file_name: 'participants.csv', type: 'text/csv') }

  before { FileUploader.upload(file , 2015) }
  after { File.delete('public/uploads/participants.csv') }

  describe '.create' do
    context 'when participants do not exist' do
      it 'saves participants from file' do
        ParticipantsCreator.create('participants.csv', year)
        expect(Participant.count).to eq(5)
      end
      it 'saves participants full name' do
        ParticipantsCreator.create('participants.csv', year)
        expect(Participant.first.full_name).to eq('Homer Simpson')
      end
      it 'saves participants partners full name' do
        ParticipantsCreator.create('participants.csv', year)
        expect(Participant.first.partner_full_name).to eq('Marge Simpson')
      end
    end

    context 'when particpants exist' do
      it 'does not create duplicates' do
        Fabricate(:participant, full_name: 'Homer Simpson')
        ParticipantsCreator.create('participants.csv', year)
        expect(Participant.count).to eq(5)
      end
      it 'updates year for all participants' do
        Fabricate(:participant, full_name: 'Homer Simpson')
        ParticipantsCreator.create('participants.csv', year)
        participants = Participant.where(year: year)
        expect(participants.count).to eq(5)
      end
    end
  end
end
