class BadAssociation < ApplicationRecord
    belongs_to :user
    belongs_to :knowledge
end
