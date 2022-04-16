class AddTechnologieToProposals < ActiveRecord::Migration[6.1]
  def change
    add_column :proposals, :technologie, :string
  end
end
