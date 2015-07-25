require 'rails_helper'

describe ResultsController do
  describe '.show' do
    it 'return 200 status' do
      get :show, id: 1
      expect(response.status).to eq(200)
    end
  end

end
