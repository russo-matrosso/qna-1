require 'rails_helper'

RSpec.describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'for quest' do
    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Comment }

    it { should_not be_able_to :manage, :all }
  end

  describe 'for admin' do
    let(:user) { create :user, admin: true }

    it { should be_able_to :manage, :all }

  end

  describe 'for user' do
    let(:user) { create :user }
    let(:other) { create :user }
    let(:question) { create(:question, user_id: user.id) }
    let(:other_question) { create :question, user_id: other.id }

    context 'Question' do
      it { should be_able_to :create, Question }

      it { should be_able_to :update, create(:question, user_id: user.id) }
      it { should_not be_able_to :update, create(:question, user_id: other.id) }

      it { should be_able_to :destroy, create(:question, user_id: user.id) }
      it { should_not be_able_to :destroy, create(:question, user_id: other.id) }

      it { should be_able_to [:like, :dislike, :cancel], create(:question, user_id: other.id) }
      it { should_not be_able_to [:like, :dislike, :cancel], create(:question, user_id: user.id) }

      it { should be_able_to [:make_comment], Question}
    end

    context 'Answer' do
      it { should be_able_to :create, Answer }

      it { should be_able_to :update, create(:answer, question: question, user_id: user.id) }
      it { should_not be_able_to :update, create(:answer, question: question, user_id: other.id) }

      it { should be_able_to :destroy, create(:answer, question: question, user_id: user.id) }
      it { should_not be_able_to :destroy, create(:answer, question: question, user_id: other.id) }

      it { should be_able_to [:like, :dislike, :cancel], create(:answer, user_id: other.id) }
      it { should_not be_able_to [:like, :dislike, :cancel], create(:answer, user_id: user.id) }

      it { should be_able_to :mark_as_best, create(:answer, question: question, user_id: other.id) }
      it { should_not be_able_to :mark_as_best, create(:answer, question: other_question, user_id: user.id) }

      it { should be_able_to [:make_comment], Answer }
    end


    context 'Link' do
      it { should be_able_to :destroy, create(:link, linkable: question) }
      it { should_not be_able_to :destroy, create(:link, linkable: other_question) }
    end
  end
end