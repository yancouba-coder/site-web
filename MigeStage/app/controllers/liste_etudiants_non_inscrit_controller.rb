class ListeEtudiantsNonInscritController < ApplicationController
  def index
    @liste_etudiants_non_inscrit = ListeEtudiant.find_by_sql("
    SELECT * FROM liste_etudiants WHERE email_universitaire NOT IN(select email_universitaire from etudiants);
")
  end
end

