FactoryBot.define do
  factory :award do
    name { 'MyAward' }
    after(:build) do |award|
      award.image.attach(
        io: File.open("#{Rails.root}/spec/images/trophy.png"),
        filename: 'award.png'
      )
    end
  end
end
