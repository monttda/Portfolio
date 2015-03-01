FactoryGirl.define do

  factory :story do
    user
    title "Dummy Title"
    points {rand(1000).to_i}
    created_at Time.now
    updated_at Time.now

    trait :with_url do
      url "https://portfolio.com"
    end

    trait :with_text do
      text "Dummy Text"
    end

    trait :with_comments do
      ignore do
        comments_count 2
        school nil
      end
      after(:create) do |story, evaluator|
        create_list(:comment,
                    evaluator.comments_count,
                    story: story
        )
      end
    end

  end
end
