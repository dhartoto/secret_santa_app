require 'rails_helper'

describe ResultsController do
  describe '.show' do
    context 'when results are available' do
      let(:year) { Fabricate(:year, year: 2015) }

      it 'return 200 status' do
        get :show, id: year.id
        expect(response.status).to eq(200)
      end
      it 'returns result for the year requested' do

        get :show, id: year.id
        expect(assigns(:year).year).to eq(2015)
      end
    end
    context 'when results are not available' do
      it 'displays error message' do
        get :show, id: 1
        msg = "Year not found"
        expect(flash[:danger]).to eq(msg)
      end
      it 'redirects back to home page' do
        get :show, id: 1
        expect(response).to redirect_to :root
      end
    end
  end

  describe '#destroy' do

    context 'when results exist' do
      let(:year) { Fabricate(:year) }
      let!(:results_1) { Fabricate(:secret_santa, year: year) }
      let!(:results_2) { Fabricate(:secret_santa, year: year) }

      it 'redirects to home page' do
        delete :destroy, id: year.id
        expect(response).to redirect_to :root
      end
      it 'displays success message' do
        delete :destroy, id: year.id
        expect(flash[:success]).to eq("Results deleted")
      end
      it 'deletes all secret santa records for selected year' do
        delete :destroy, id: year.id
        expect(SecretSanta.count).to eq(0)
      end
    end
    context 'when results do not exist' do
      it 'displays error message' do
        delete :destroy, id: 2
        expect(flash[:danger]).to eq("No results found")
      end
    end
  end
end
