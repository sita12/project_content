require 'rails_helper'

RSpec.describe "Api::V1::Contents", type: :request do
  describe ' controller test cases ' do

    let(:user1) { FactoryBot.create(:user, email: "kim@gmail.com") }
    let(:project1) { FactoryBot.create(:project, user: user1) }
    let(:content1) { FactoryBot.create(:content, project: project1) }

    describe '#create' do
      it 'should give status 200' do
        post "/api/v1/projects/#{project1.id}/contents", params: {title: "Project content title", body: "Project content body" }, as: :json, headers: authentication_header(user1)
        expect(response.status).to eq(200)
        expect(response).to match_json_schema("content")
      end
      it 'should give status 422' do
        post "/api/v1/projects/#{project1.id}/contents", params: {}, as: :json, headers: authentication_header(user1)
        expect(response.status).to eq(422)
      end
    end

    describe '#update' do
      it 'should give status 200' do
        put "/api/v1/projects/#{project1.id}/contents/#{content1.id}", params: {title: "Updated Project content title", body: "Updated Project content body" }, as: :json, headers: authentication_header(user1)
        expect(response.status).to eq(200)
        expect(response).to match_json_schema("content")
      end
    end

    describe '#show' do
      it 'should give status 200' do
        get "/api/v1/projects/#{project1.id}/contents/#{content1.id}", headers: authentication_header(user1)
        expect(response.status).to eq(200)
        expect(response).to match_json_schema("content")
      end
    end

    describe '#index' do
      it 'should give status 200' do
        get "/api/v1/projects/#{project1.id}/contents", headers: authentication_header(user1)
        expect(response.status).to eq(200)
        expect(response).to match_json_schema("contents")
      end
    end

    describe '#destroy' do
      it 'should give status 200' do
        user2 = FactoryBot.create(:user, email: "test3@gmail.com") 
        project2 =  FactoryBot.create(:project, user: user2)
        content2 =  FactoryBot.create(:content, project: project2)
        delete "/api/v1/projects/#{project2.id}/contents/#{content2.id}", headers: authentication_header(user2)
        expect(response.status).to eq(200)
      end
    end
  end
end
