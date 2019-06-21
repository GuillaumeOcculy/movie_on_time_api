require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do
  describe '#create' do
    context 'when params are valid' do
      it 'adds a user' do
        user_params = attributes_for(:user)
        expect { post :create, params: user_params }.to change(User, :count).by(1)
      end

      it 'returns a 201 response' do
        user_params = attributes_for(:user)
        post :create, params: user_params
        expect(response).to have_http_status '201'
      end
    end

    context 'when params are invalid' do
      it 'returns a 422 response' do
        user_params = attributes_for(:user, :invalid)
        post :create, params: user_params
        expect(response).to have_http_status '422'
      end

      describe 'for email attribute' do
        it 'fails when email is invalid' do
          user_params = attributes_for(:user, email: 'wrong_email')
          post :create, params: user_params
          body = Oj.load response.body
          expect(body['email']).to eq ['is invalid']
        end

        it 'fails when email is absent' do
          user_params = attributes_for(:user, email: nil)
          post :create, params: user_params
          body = Oj.load response.body
          expect(body['email']).to eq ['can\'t be blank']
        end

        it 'fails when email is duplicated' do
          create(:user, email: 'test@test.com')
          user_params = attributes_for(:user, email: 'test@test.com')
          post :create, params: user_params
          body = Oj.load response.body
          expect(body['email']).to eq ['has already been taken']
        end     
      end

      describe 'for password attribute' do
        it 'fails when password is too short' do
          user_params = attributes_for(:user, password: 'short')
          post :create, params: user_params
          body = Oj.load response.body
          expect(body['password']).to eq ['is too short (minimum is 6 characters)']
        end

        it 'fails when password is absent' do
          user_params = attributes_for(:user, password: nil)
          post :create, params: user_params
          body = Oj.load response.body
          expect(body['password']).to eq ['can\'t be blank']
        end  
      end 
    end
  end
end
