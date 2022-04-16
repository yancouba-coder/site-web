class AddUrlToProposals < ActiveRecord::Migration[6.1]
  def change
    add_column :proposals, :url, :string
  end
end
