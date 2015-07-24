require 'rails_helper'
require 'data_importer'

describe DataImporter do
  describe '.import' do
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

    context 'when file upload successful' do
      it 'sets status to 200'
      it 'saves year'
      it 'saves participants'
      it 'creates secret santas'
    end
    context 'when file upload unsuccesful' do
      it 'does not save year'
      it 'does not save participants'
      it 'does not create secret santas'
      it 'assigns error_message'
      it 'sets status to 400'
    end
  end

  describe '#successful?' do
    it { should respond_to :successful? }
  end
end
