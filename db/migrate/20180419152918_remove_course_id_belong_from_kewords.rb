class RemoveCourseIdBelongFromKewords < ActiveRecord::Migration[5.0]
  def change
    remove_column :keywords, :Course_ID_belong, :string
  end
end
