class CreateTechnologies < ActiveRecord::Migration[6.1]
  def change
    create_table :technologies do |t|
      t.string :tag
    end
    add_index :technologies, :tag, unique: true
  end
end
