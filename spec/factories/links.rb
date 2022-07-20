FactoryBot.define do
  factory :link do
    name { 'Google' }
    url { "http://google.com" }
    #association :linkable, factory: :question
  end
end
