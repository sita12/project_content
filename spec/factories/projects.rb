FactoryBot.define do
  factory :project do
    user { FactoryBot.create(:user, email: "mark@gmail.com") }
    title { "Project" }
    description { "My first Project" }
    location { "US" }
    project_type { "in_house" }
    thumbnail { Rack::Test::UploadedFile.new('spec/fixtures/project.png', 'thumbail/png') } 
  end
end
