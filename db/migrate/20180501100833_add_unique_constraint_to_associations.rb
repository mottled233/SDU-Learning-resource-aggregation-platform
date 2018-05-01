class AddUniqueConstraintToAssociations < ActiveRecord::Migration[5.0]
  def change
    add_index :good_associations,
              [:user_id, :knowledge_id], unique: true, name: :unique_index_on_ga
    add_index :bad_associations,
              [:user_id, :knowledge_id], unique: true, name: :unique_index_on_ba
    add_index :course_user_associations,
              [:user_id, :course_id], unique: true
    add_index :focus_knowledge_associations,
              [:user_id, :knowledge_id], unique: true, name: :unique_index_on_fka
              
    add_index :course_knowledge_associations,
              [:course_id, :knowledge_id], unique: true, name: :unique_index_on_cka
    add_index :course_keyword_associations,
              [:course_id, :keyword_id], unique: true, name: :unique_index_on_ckeya
    add_index :keyword_knowledge_associations,
              [:keyword_id, :knowledge_id], unique: true, name: :unique_index_on_kka
    add_index :keyword_relationships,
              [:higher_id, :lower_id], unique: true, name: :unique_index_on_keya
    add_index :course_department_associations,
              [:course_id, :department_id], unique: true, name: :unique_index_on_cda
    add_index :course_speciality_associations,
              [:course_id, :speciality_id], unique: true, name: :unique_index_on_csa
    
    
    
  end
end
