require 'rails_helper'

RSpec.describe "Api::V1::Projects", type: :request do
  describe ' controller test cases ' do

    let(:user1) { FactoryBot.create(:user, email: "marry@gmail.com") }
    let(:project11) { FactoryBot.create(:project, user: user1) }

    describe '#create' do
      it 'should give status 200' do
        post "/api/v1/projects", params: {title: "Project", project_type: "in_house", description: "New Project", location: "US", thumbnail: Rack::Test::UploadedFile.new('spec/fixtures/project.png', 'thumbail/png') }, as: :form, headers: authentication_header(user1)
        expect(response.status).to eq(200)
        expect(response).to match_json_schema("project")
      end
      it 'should give status 422' do
        post "/api/v1/projects", params: {}, as: :form, headers: authentication_header(user1)
        expect(response.status).to eq(422)
      end
    end
  end
end
