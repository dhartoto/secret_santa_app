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
      post :create, year: 2015
      expect(response).to redirect_to :root
    end
  end
end
