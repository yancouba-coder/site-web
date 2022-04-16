class CreateGeFormat < ActiveRecord::Migration[6.1]
  def change
    create_table :ge_formats do |t|
      t.text :contenu

      t.timestamps
    end
  end
end
