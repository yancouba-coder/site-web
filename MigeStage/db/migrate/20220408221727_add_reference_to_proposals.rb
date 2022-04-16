class AddReferenceToProposals < ActiveRecord::Migration[6.1]
  def change
    add_column :proposals, :reference, :string
  end
end
