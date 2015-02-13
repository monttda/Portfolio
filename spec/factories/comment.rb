FactoryGirl.define do

  factory :comment do
    user
    text "Dummy Text"
    points {rand(1000).to_i}
    created_at Time.now
    updated_at Time.now
  end
end
