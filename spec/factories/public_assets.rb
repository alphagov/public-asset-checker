FactoryBot.define do
  factory :public_asset do
    url { "https://www.bedrock.com/" }
    validate_by { "size" }
  end
end
