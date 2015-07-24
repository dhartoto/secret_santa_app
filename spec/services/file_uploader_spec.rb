require 'rails_helper'

describe FileUploader do
  describe '.upload' do
    it 'returns an instance of FileUploader' do
      uploader = FileUploader.upload('file.csv')
      expect(uploader).to be_an_instance_of(FileUploader)
    end
    it { should respond_to :status }
    it { should respond_to :error_message }

    context 'when valid file type' do
      it 'saves file'
      it 'returns status 200'
    end
    context 'when file present'
    context 'when invalid file type' do

    end

  end

  describe '#successful?' do
    it { should respond_to :successful? }
  end
end
