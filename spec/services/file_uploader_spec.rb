require 'rails_helper'

# Mock files are in spec/fixtures
# Helper methods are in support/macros.rb

describe FileUploader do
  describe '.upload' do

    it 'returns an instance of FileUploader' do
      uploader = FileUploader.upload(mock_file(file_name: 'participants.csv'))
      expect(uploader).to be_an_instance_of(FileUploader)
    end

    it { should respond_to :status }
    it { should respond_to :error_message }

    context 'when valid file type' do
      after { File.delete('public/uploads/participants.csv') }

      it 'saves file' do
        FileUploader.upload(mock_file(file_name: 'participants.csv'))
        file_exist = File.exist?('public/uploads/participants.csv')
        expect(file_exist).to eq(true)
      end
      it 'returns status 200' do
        resp = FileUploader.upload(mock_file(file_name: 'participants.csv'))
        expect(resp.status).to eq(200)
      end
    end

    context 'when file present'
    context 'when invalid file type'
  end

  describe '#successful?' do
    it { should respond_to :successful? }
  end
end
