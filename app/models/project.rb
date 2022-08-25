class Project < ApplicationRecord

  ##RELATIONS
  belongs_to :user
  has_one_attached :thumbnail
  has_many :contents, dependent: :destroy

  ##VALIDATIONS
  validates_presence_of :title, :project_type, :location, :thumbnail

  ## ENUM
  enum project_type: {in_house: 0, external: 1, international: 2}
end
