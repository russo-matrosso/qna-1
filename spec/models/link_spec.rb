require 'rails_helper'

RSpec.describe Link, type: :model do
  it { should belong_to :linkable }

  it { should validate_presence_of :name }
  it { should validate_presence_of :url }

  let(:question) { create(:question) }
  let(:gist) { create(:link, linkable: question, name: 'my gist', url: 'https://gist.github.com/zdvbind/a014b25d493bba679e7c8dfbb4854d77') }
  let(:not_gist) { create(:link, linkable: question, name: 'yandex', url: 'http://ya.ru') }

  describe 'is a gist ?' do
    it 'should be true if link is a gist' do
      expect(gist).to be_is_a_gist
    end

    it 'should be false if link is a gist' do
      expect(not_gist).to_not be_is_a_gist
    end
  end
end
