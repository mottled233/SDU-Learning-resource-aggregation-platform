class Course < ApplicationRecord
  has_and_belongs_to_many :departments
  has_and_belongs_to_many :users
  has_and_belongs_to_many :knowledges
  has_and_belongs_to_many :keywords
end
