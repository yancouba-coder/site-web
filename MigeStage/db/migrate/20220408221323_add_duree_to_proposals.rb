class AddDureeToProposals < ActiveRecord::Migration[6.1]
  def change
    add_column :proposals, :duree, :string
  end
end
