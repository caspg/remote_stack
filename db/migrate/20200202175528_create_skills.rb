class CreateSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :skills do |t|
      t.string :name, index: { unique: true }

      t.timestamps
    end
  end
end
