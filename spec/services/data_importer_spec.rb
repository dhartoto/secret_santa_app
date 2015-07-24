require 'rails_helper'
require 'data_importer'

describe DataImporter do
  describe '.import' do

    context 'when uploading file' do
      let(:uploader) { instance_double('FileUploader',
        successful?: true) }

      before do
        allow(FileUploader).to receive(:upload) { uploader }
        allow(SecretSantaCreator).to receive(:create)
      end

      it 'responds to import' do
        expect(DataImporter).to respond_to(:import)
        importer = DataImporter.import('some_file.csv', 2015)
      end
      it { should respond_to :error_message}

      it 'creates an instance of data importer' do
        importer = DataImporter.import('some_file.csv', 2015)
        expect(importer).to be_an_instance_of(DataImporter)
      end
      it 'updloads file' do
        expect(FileUploader).to receive(:upload)
        DataImporter.import('some_file.csv', 2015)
      end
    end

    context 'when file upload successful' do
      let(:uploader) { instance_double('FileUploader',
        successful?: true) }

      before do
        allow(FileUploader).to receive(:upload) { uploader }
        allow(SecretSantaCreator).to receive(:create)
      end
      it 'sets status to 200' do
        importer = DataImporter.import('some_file.csv', 2015)
        expect(importer.status).to eq(200)
      end
      it 'creates secret santas' do
        expect(SecretSantaCreator).to receive(:create)
        DataImporter.import('some_file.csv', 2015)
      end
      it 'saves year' do
        DataImporter.import('some_file.csv', 2015)
        expect(Year.count).to eq(1)
      end
    end

    context 'when file upload unsuccesful' do
      let(:uploader) { instance_double('FileUploader',
        successful?: false, error_message: 'error') }

      before do
        allow(FileUploader).to receive(:upload) { uploader }
        allow(SecretSantaCreator).to receive(:create)
      end

      it 'does not save year' do
        DataImporter.import('some_file.csv', 2015)
        expect(Year.count).to eq(0)
      end
      it 'does not create secret santas' do
        expect(SecretSantaCreator).not_to receive(:create)
        DataImporter.import('some_file.csv', 2015)
      end
      it 'assigns error_message' do
        importer = DataImporter.import('some_file.csv', 2015)
        expect(importer.error_message).to eq('error')
      end
      it 'sets status to 400' do
        importer = DataImporter.import('some_file.csv', 2015)
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
