class CreateGoodAssociations < ActiveRecord::Migration[5.0]
  def change
    create_table :good_associations do |t|
      t.belongs_to :user, foreign_key: true, index: true
      t.belongs_to :knowledge, foreign_key: true, index: true
      
      t.timestamps
      
    end
  end
end
