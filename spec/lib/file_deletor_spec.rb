require 'rails_helper'

describe FileDeletor do
  describe '.delete' do
    context 'when file exists' do
      let(:file) { OpenStruct.new(original_filename: 'participants.csv') }
      before { FileUploader.upload(mock_file(file_name: 'participants.csv'), 2015) }

      it 'deletes file from public/uploads' do
        FileDeletor.delete(file)
        file_exist = File.exist?('public/uploads/participants.csv')
        expect(file_exist).to eq(false)
      end
    end
  end
end
