class AddIntroductionToCourse < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :introduction, :text
  end
end
