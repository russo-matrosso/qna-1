require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  let(:question) { create(:question, author: user) }
  let(:user) { create(:user) }

  describe 'POST #create' do
    let(:create_request) { post :create, params: { question_id: question, format: :js } }

    context 'authenticated user' do
      before { login(user) }

      it 'saves question subscription in database' do
        expect { create_request }.to change(question.subscriptions, :count).by(1)
      end

      it 'assigns subscription to current_user' do
        create_request
        expect(assigns(:subscription).user).to eq user
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:subscription) { create(:subscription, question: question, user: user) }
    let(:destroy_request) { delete :destroy, params: { id: subscription, format: :js } }
    
    context 'authenticated user' do
      it "deletes subscription from database" do
        login(user)
        expect { destroy_request }.to change(question.subscriptions, :count).by(-1)
      end
    end
  end
end