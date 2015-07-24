require 'rails_helper'

describe ParticipantsController do

  describe '#index' do
    it 'request successful' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe '#create' do
    it 'request successful' do
      post :create, year: 2015
      expect(response.status).to eq(200)
    end
  end
end
