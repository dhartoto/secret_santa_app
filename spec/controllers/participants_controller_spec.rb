require 'rails_helper'

describe ParticipantsController do

  describe '#index' do
    it 'request successful' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe '#create' do
    it 'redirects to root' do
      importer = instance_double('DataImporter', successful?: true)
      allow(DataImporter).to receive(:import).and_return(importer)
      post :create, file: 'file.csv', year: 2015
      expect(response).to redirect_to :root
    end
    it 'imports data' do
      importer = instance_double('DataImporter', successful?: true)
      allow(DataImporter).to receive(:import).and_return(importer)
      expect(DataImporter).to receive(:import)
      post :create, year: 2015
    end
    context 'when file is valid' do
      it 'display success message' do
        importer = instance_double('DataImporter', successful?: true)
        allow(DataImporter).to receive(:import).and_return(importer)
        post :create, file: 'file.csv', year: 2015
        expect(flash[:success]).to eq("File uploaded successfully")
      end
    end
    context 'when file is not valid' do
      it 'display failure message' do
        importer = instance_double('DataImporter',
          successful?: false, error_message: "Computer says no!")
        allow(DataImporter).to receive(:import).and_return(importer)
        post :create, file: 'file.csv', year: 2015
        expect(flash[:alert]).to eq("Computer says no!")
      end
    end
  end
end
