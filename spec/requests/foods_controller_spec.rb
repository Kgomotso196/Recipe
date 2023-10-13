require 'rails_helper'

RSpec.describe FoodsController, type: :request do
  describe 'Foods' do
    let(:user) { User.new(name: 'test', email: 'test@test.com', password: 'password') }
    let(:food) { Food.new(name: 'food', measurement_unit: 'units', price: 10, quantity: 10, user_id: user.id) }
    before do
      user.skip_confirmation!
      user.save
      authenticate_user(user)
      food.save
    end
    def authenticate_user(user)
      post user_session_path, params: { user: { email: user.email, password: user.password } }
      follow_redirect!
    end
    describe '#index' do
      it 'returns a success response' do
        get root_path
        expect(response).to have_http_status(:ok)
      end
    end
    describe '#new' do
      it 'returns a success response' do
        get new_food_path
        expect(response).to have_http_status(:ok)
      end
    end

    describe '#destroy' do
      it 'returns a success response' do
        delete food_path(food)
        expect(response).to redirect_to(foods_path)
      end
    end
  end
end
