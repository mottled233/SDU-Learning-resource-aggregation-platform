class CreateFocusContentsFollowers < ActiveRecord::Migration[5.0]
  def change
    create_table :focus_contents_followers do |t|
      t.belongs_to :user, index: :true
      t.belongs_to :knowledge, index: :true
    end
  end
end
