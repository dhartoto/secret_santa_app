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
end
