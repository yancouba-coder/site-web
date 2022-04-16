class DisponibilitesController < ApplicationController
  def index
    @promotion_ouvertes = Promotion.where(statut: "OUVERTE").order(annee: :desc)
    @disponibilites = Disponibilite.where(promotions: @promotion_ouverte)
  end

  def new
    @promotion_ouvertes = Promotion.where(statut: "OUVERTE").order(annee: :desc)
    @disponibilite = Disponibilite.new
  end

  def create
    @disponibilite = Disponibilite.create(disponibilite_param)

    if @disponibilite.save
      redirect_to disponibilites_path
    end
  end

  def destroy
    disponibilite = Disponibilite.find(params[:id])
    disponibilite.destroy

    redirect_to disponibilites_path
  end

  private

  def disponibilite_param
    params.require(:disponibilite).permit(:tuteur_universitaire_id, :promotion_id, :nb_etudiants_souhaite, :statut_reponse)
  end
end
