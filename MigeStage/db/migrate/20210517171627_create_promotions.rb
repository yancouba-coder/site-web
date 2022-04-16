class CreatePromotions < ActiveRecord::Migration[6.1]
  def change
    create_table :promotions do |t|
      t.string :annee, limit: 4
    end

    add_index :promotions, :annee, unique: true
  end
end
