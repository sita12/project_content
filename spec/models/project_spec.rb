require 'rails_helper'

RSpec.describe Project, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  before(:all) do
    @project1 = FactoryBot.create(:project)
    @user1 = @project1.user
  end
  
  it "is valid with valid attributes" do
    expect(@project1).to be_valid
  end
  
  it "is not valid without a title" do 
    project1 = FactoryBot.build(:project, user: @user1, title: nil)
    expect(project1).to_not be_valid
  end

  it "is not valid without a location" do 
    project1 = FactoryBot.build(:project, user: @user1, location: nil)
    expect(project1).to_not be_valid
  end

  it "is not valid without a project_type" do 
    project1 = FactoryBot.build(:project, user: @user1, project_type: nil)
    expect(project1).to_not be_valid
  end

  it "is not valid without a thumbnail" do 
    project1 = FactoryBot.build(:project, user: @user1, thumbnail: nil)
    expect(project1).to_not be_valid
  end
end
