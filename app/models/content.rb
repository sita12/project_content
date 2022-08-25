class Content < ApplicationRecord

  ##RELATIONS
  belongs_to :project

  ## DELEGATE
  delegate :user, to: :project

  ##VALIDATIONS
  validates_presence_of :title, :body
end
