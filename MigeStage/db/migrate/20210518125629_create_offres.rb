class CreateOffres < ActiveRecord::Migration[6.1]
  def change
    create_table :offres do |t|
      t.string :titre
      t.string :type_offre
      t.string :lien_url
      t.string :mention
      t.binary :pdf
      t.date :date_publication
      t.string :sujet

      t.belongs_to :entreprise, foreign_key: true
    end

    # add_check_constraint :offres, 'type_offre IN ("STAGE","ALTERNANCE")'
    # add_check_constraint :offres, 'mention IN ("L3","M1", "M2")'
  end
end
