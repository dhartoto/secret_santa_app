require 'rails_helper'

describe SecretSantaCreator do
  describe '.create' do
    it { should be_an_instance_of(SecretSantaCreator) }

    let(:year) { Fabricate(:year, year: 2015) }
    let(:file) { mock_file(file_name: 'participants.csv', type: 'text/csv') }

    before { FileUploader.upload(file , 2015) }
    after { File.delete('public/uploads/participants.csv') }

    it 'should create a secret santa for each person' do
      SecretSantaCreator.create(year)
      expect(SecretSanta.count).to eq(5)
    end
    it 'should not be themselves'
    it 'should not be their partners'
    it 'should not not have duplicate secret santas'
    it 'should not be the same as last year'

    context 'when no Secret Santa last year'

  end

end
