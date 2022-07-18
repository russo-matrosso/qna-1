FactoryBot.define do
  factory :question do
    title { 'MyString' }
    body { 'MyText' }
    association :author, factory: :user

    trait :invalid do
      title { nil }
    end
  end

  trait :with_attachment do
    after :create do |question|
      question.files.attach(io: File.open("#{Rails.root}/spec/rails_helper.rb"),
                            filename: 'rails_helper.rb')
    end
  end
end
