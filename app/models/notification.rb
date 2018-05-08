class Notification < ApplicationRecord
  include NotificationsHelper
  # validates
  validates :user_id, presence: true
  validates :entity_type, presence: true
  validates :notify_entity_id, presence: true
  validates :notify_type, presence: true
  
  # associations
  belongs_to :user
  
  # instance method
  def to_std_model
    
  end
  
end
