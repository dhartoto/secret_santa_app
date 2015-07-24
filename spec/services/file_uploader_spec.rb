require 'rails_helper'

# Mock files are in spec/fixtures
# Helper methods are in support/macros.rb

describe FileUploader do
  describe '.upload' do

    it 'returns an instance of FileUploader' do
      uploader = FileUploader.upload(mock_file(file_name: 'participants.csv'),
        2015)
      expect(uploader).to be_an_instance_of(FileUploader)
    end

    it { should respond_to :status }
    it { should respond_to :error_message }

    context 'when valid file type' do
      after { File.delete('public/uploads/participants.csv') }

      it 'saves file' do
        FileUploader.upload(mock_file(file_name: 'participants.csv'), 2015)
        file_exist = File.exist?('public/uploads/participants.csv')
        expect(file_exist).to eq(true)
      end
      it 'returns status 200' do
        resp = FileUploader.upload(mock_file(file_name: 'participants.csv'), 2015)
        expect(resp.status).to eq(200)
      end
    end

    context 'when year already present' do
      before { Fabricate(:year, year: 2015) }

      it 'returns status 400' do
        resp = FileUploader.upload(mock_file(file_name: 'participants.csv',
         type: 'text/csv'), 2015)
        expect(resp.status).to eq(400)
      end
      it 'set error_message' do
        resp = FileUploader.upload(mock_file(file_name: 'participants.csv',
          type: 'text/csv'), 2015)
        msg = 'Participants list for this year already exists.'
        expect(resp.error_message).to eq(msg)
      end
    end
    context 'when invalid file type' do

      it 'does not save file' do
        FileUploader.upload(mock_file(file_name: 'participants.txt',
          type: 'text/plain'), 2015)
        file_exist = File.exist?('public/uploads/participants.txt')
        expect(file_exist).to eq(false)
      end
      it 'returns status 400' do
        resp = FileUploader.upload(mock_file(file_name: 'participants.txt',
          type: 'text/plain'), 2015)
        expect(resp.status).to eq(400)
      end
      it 'set error_message' do
        resp = FileUploader.upload(mock_file(file_name: 'participants.txt',
          type: 'text/plain'), 2015)
        msg = 'Invalid file. Please upload a CSV file.'
        expect(resp.error_message).to eq(msg)
      end
    end

    context 'when no file' do
      it 'returns status 400' do
        resp = FileUploader.upload(nil, 2015)
        expect(resp.status).to eq(400)
      end
      it 'set error_message' do
        resp = FileUploader.upload(nil, 2015)
        msg = 'No file selected. Please upload a CSV file.'
        expect(resp.error_message).to eq(msg)
      end
    end

    context 'when file is empty' do
      let!(:resp) { FileUploader.upload(mock_file(file_name: 'empty_file.csv' ),
        2015) }
      after       { clear_upload_file('empty_file.csv') }

      it 'returns status 400' do
        expect(resp.status).to eq(400)
      end
      it 'set error_message' do
        msg = 'File empty. Please add participants and try again.'
        expect(resp.error_message).to eq(msg)
      end
    end
  end

  describe '#successful?' do
    it { should respond_to :successful? }
  end
end
