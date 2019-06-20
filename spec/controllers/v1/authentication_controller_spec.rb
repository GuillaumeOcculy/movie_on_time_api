require 'rails_helper'

RSpec.describe V1::AuthenticationController, type: :controller do
  before do
    create(:user, email: 'test@example.com', password: 'password')
  end

  describe '#create' do
    it 'authenticates successfully' do
      post :create, params: { email: 'test@example.com', password: 'password' }
      expect(response).to have_http_status '200'
    end

    it 'returns invalid email when inexistant user' do
      post :create, params: { email: 'wrong@email.com', password: 'wrong_password' }
      expect(response).to have_http_status '422'
    end

    it 'returns invalid password' do
      post :create, params: { email: 'test@example.com', password: 'wrong_password' }
      expect(response).to have_http_status '422'
    end
  end
end
