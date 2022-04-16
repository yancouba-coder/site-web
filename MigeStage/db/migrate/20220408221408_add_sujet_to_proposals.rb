class AddSujetToProposals < ActiveRecord::Migration[6.1]
  def change
    add_column :proposals, :sujet, :string
  end
end
