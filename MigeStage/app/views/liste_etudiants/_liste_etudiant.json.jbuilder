json.extract! liste_etudiant, :id, :num_etudiant, :nom, :prenom, :email_universitaire, :email_personnel, :statut_arrivant_L3, :mention, :stage, :alternance, :created_at, :updated_at
json.url liste_etudiant_url(liste_etudiant, format: :json)
