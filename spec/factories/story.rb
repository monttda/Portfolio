FactoryGirl.define do

  factory :story do
    user
    text "Dummy Text"
    title "Dummy Title"
    points {rand(1000).to_i}
    url "portfolio.com"
    created_at Time.now
    updated_at Time.now
  end
end
