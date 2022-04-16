
class ResponsableStagesController < ApplicationController
  def destroy
    res = ResponsableStage.find(params[:id])
    res.destroy

    redirect_to menurespstage_path
  end
  def show
    session.destroy
    redirect_to :root
  end
  def changer_tuteur
    @fichestage= FicheStage.find(params[:id])
    @etudiant=Etudiant.find @fichestage.etudiant_id
    @etudiant.tuteur_universitaires_id=params[:etudiant][:tuteur_universitaires_id]
    @tuteur= TuteurUniversitaire.find @etudiant.tuteur_universitaires_id
    @etudiant.save
    render :changer_tuteur

  end
end