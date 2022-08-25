FactoryBot.define do
  factory :content do
    project { FactoryBot.create(:project, user: FactoryBot.create(:user, email: "henry@gmail.com")) }
    title { "Project content" }
    body { "My first Project Content" }
  end
end
