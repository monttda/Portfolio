FactoryGirl.define do

  factory :comment do
    user
    text "Dummy Text"
    points {rand(1000).to_i}
    created_at Time.now
    updated_at Time.now

    trait :with_comments do
      ignore do
        comments_count 2
        school nil
      end
      after(:create) do |comment, evaluator|
        create_list(:comment,
                    evaluator.comments_count,
                    parent: comment
        )
      end
    end
  end
end
