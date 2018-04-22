class CreateCoursesUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :courses_users do |t|
      t.belongs_to :user, index: true
      t.belongs_to :course, index: true
      
    end
  end
end
