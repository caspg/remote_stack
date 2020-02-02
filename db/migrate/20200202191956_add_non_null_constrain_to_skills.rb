class AddNonNullConstrainToSkills < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:skills, :name, false)
  end
end
