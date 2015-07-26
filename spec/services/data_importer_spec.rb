require 'rails_helper'
require 'data_importer'

describe DataImporter do
  describe '.import' do
    let(:file) { OpenStruct.new(original_filename: 'participants.csv') }
    let(:participants) { instance_double('ParticipantsCreator') }

    before do
      allow(ParticipantsCreator).to receive(:new) { participants}
      allow(participants).to receive(:create)
    end

    context 'when uploading file' do
      let(:uploader) { instance_double('FileUploader',
        successful?: true) }

      before do
        allow(FileUploader).to receive(:upload) { uploader }
      end

      it 'responds to import' do
        expect(DataImporter).to respond_to(:import)
        importer = DataImporter.import(file, 2015)
      end
      it { should respond_to :error_message}

      it 'creates an instance of data importer' do
        importer = DataImporter.import(file, 2015)
        expect(importer).to be_an_instance_of(DataImporter)
      end
      it 'updloads file' do
        expect(FileUploader).to receive(:upload)
        DataImporter.import(file, 2015)
      end
    end

    context 'when file upload successful' do
      let(:uploader) { instance_double('FileUploader',
        successful?: true) }
      let(:secret_santa) { instance_double('SecretSantaCreator') }

      before do
        allow(FileUploader).to receive(:upload) { uploader }
        allow(SecretSantaCreator).to receive(:new) { secret_santa }
        allow(secret_santa).to receive(:create)
      end
      it 'sets status to 200' do
        importer = DataImporter.import(file, 2015)
        expect(importer.status).to eq(200)
      end
      it 'creates secret santas' do
        expect(SecretSantaCreator).to receive(:new)
        DataImporter.import(file, 2015)
      end
      it 'saves year' do
        DataImporter.import(file, 2015)
        expect(Year.count).to eq(1)
      end
    end

    context 'when file upload unsuccesful' do
      let(:uploader) { instance_double('FileUploader',
        successful?: false, error_message: 'error') }
      let(:secret_santa) { instance_double('SecretSantaCreator') }

      before do
        allow(FileUploader).to receive(:upload) { uploader }
        allow(SecretSantaCreator).to receive(:new) { secret_santa }
      end

      it 'does not save year' do
        DataImporter.import(file, 2015)
        expect(Year.count).to eq(0)
      end
      it 'does not create secret santas' do
        expect(SecretSantaCreator).not_to receive(:new)
        DataImporter.import(file, 2015)
      end
      it 'assigns error_message' do
        importer = DataImporter.import(file, 2015)
        expect(importer.error_message).to eq('error')
      end
      it 'sets status to 400' do
        importer = DataImporter.import(file, 2015)
        expect(importer.status).to eq(400)
      end
    end
  end

  describe '#successful?' do

    context 'when status 200' do
      it 'is successful' do
        importer = DataImporter.new(status: 200)
        expect(importer).to be_successful
      end
    end

    context 'when status 400' do
      it 'is not successful' do
        importer = DataImporter.new(status: 400)
        expect(importer).not_to be_successful
      end
    end
  end
end
