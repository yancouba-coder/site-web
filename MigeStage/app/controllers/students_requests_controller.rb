class StudentsRequestsController < ApplicationController

  def students_who_are_in_initial_education
    @initial_education = ListeEtudiant.find_by_sql "select * from liste_etudiants where alternance = 'FI'";
  end

  def students_who_are_on_work_study_programs
    @alternates = ListeEtudiant.find_by_sql "select * from liste_etudiants where alternance = 'Apprentis'";
  end

  def students_in_L3
    @students_in_L3 = ListeEtudiant.find_by_sql "select * from liste_etudiants where mention = 'L3'";
  end

  def students_in_M1
    @students_in_M1 = ListeEtudiant.find_by_sql "select * from liste_etudiants where mention = 'M1'";
  end

  def students_in_M2
    @students_in_M2 = ListeEtudiant.find_by_sql "select * from liste_etudiants where mention= 'M2'";
  end

end
