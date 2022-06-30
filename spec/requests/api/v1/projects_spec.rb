require 'rails_helper'

RSpec.describe "Api::V1::Projects", type: :request do
  describe ' controller test cases ' do

    let(:user1) { FactoryBot.create(:user, email: "marry@gmail.com") }
    let(:project1) { FactoryBot.create(:project, user: user1) }
    let(:new_user) { FactoryBot.create(:user, email: "kat@gmail.com") }

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

    describe '#update' do
      it 'should give status 200' do
        put "/api/v1/projects/#{project1.id}", params: {title: "Project", project_type: "in_house", description: "New Project", location: "US" }, as: :json, headers: authentication_header(user1)
        expect(response.status).to eq(200)
        expect(response).to match_json_schema("project")
      end
      it 'should give status 401' do
        put "/api/v1/projects/#{project1.id}", params: {title: "Project", project_type: "in_house", description: "New Project", location: "US" }, as: :json, headers: authentication_header(new_user)
        expect(response.status).to eq(401)
      end
    end

    describe '#show' do
      it 'should give status 200' do
        get "/api/v1/projects/#{project1.id}"
        expect(response.status).to eq(200)
        expect(response).to match_json_schema("project")
      end
    end

    describe '#index' do
      it 'should give status 200' do
        get "/api/v1/projects"
        expect(response.status).to eq(200)
        expect(response).to match_json_schema("projects")
      end
    end

    describe '#my_projects' do
      it 'should give status 200' do
        get "/api/v1/projects/my_projects", headers: authentication_header(user1)
        expect(response.status).to eq(200)
        expect(response).to match_json_schema("projects")
      end
    end

    describe '#destroy' do
      it 'should give status 200' do
        user2 = FactoryBot.create(:user, email: "test@gmail.com") 
        project2 =  FactoryBot.create(:project, user: user2)
        delete "/api/v1/projects/#{project2.id}", headers: authentication_header(user2)
        expect(response.status).to eq(200)
      end
      it 'should give status 401' do
        user2 = FactoryBot.create(:user, email: "test@gmail.com") 
        project2 =  FactoryBot.create(:project, user: user2)
        delete "/api/v1/projects/#{project2.id}", headers: authentication_header(user1)
        expect(response.status).to eq(401)
      end
    end
  end
end
