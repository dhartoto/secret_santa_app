require 'rails_helper'

describe ParticipantsController do
  describe '#index' do
    it 'request successful' do
      get :index
      expect(response.status).to eq(200)
    end
  end
end
