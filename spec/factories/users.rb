FactoryBot.define do
  factory :user do
    email { FFaker::Internet.free_email }
    name { FFaker::NameRU.first_name }
  end
end
