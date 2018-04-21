class Knowledge < ApplicationRecord
  belongs_to :course
  belongs_to :user
  has_many:replies
  def self.inherited(child)
      child.instance_eval do
        def model_name
          Knowledge.model_name
        end
      end
    super
  end
  def Knowledge.get_all_entry(entry_type)
    Knowledge.where(:type => entry_type).all
  end
end
