FactoryGirl.define do

  factory :user do
    email    "test"
    password "user"
    password_confirmation { password }
  end
end
