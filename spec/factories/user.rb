FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "this_email_wont_exist_#{n}@portfolio.com"}
    encrypted_password  {"user_#{rand(1000).to_s}"}
    provider  {"provider_#{rand(1000).to_s}"}
    password "password"
    uid {"uid_#{rand(1000).to_s}"}
    created_at Time.now
    updated_at Time.now
  end
end
