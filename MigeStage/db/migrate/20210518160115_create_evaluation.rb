class CreateEvaluation < ActiveRecord::Migration[6.1]
  def change
    create_table :evaluations do |t|
      t.text :contenu
      t.boolean :auto_evalution

      t.belongs_to :stage, foreign_key: true
      t.belongs_to :ge_format, foreign_key: true
      t.timestamps
    end
  end
end
