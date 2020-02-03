class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :slug, null: false
    end

    add_index :companies, :slug, unique: true
  end
end
