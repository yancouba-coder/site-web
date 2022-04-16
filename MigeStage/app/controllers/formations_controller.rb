class FormationsController < ApplicationController
  def index
    @formations = Formation.all
    @formation = Formation.create
  end

  def new
    @formation = Formation.new
    @formation.promotion_id = params[:promotion_id]
  end

  def create
    @formation = Formation.new(post_params)

    if @formation.save
      redirect_to promotion_path(@formation.promotion)
    end
  end

  def edit
    @formation = Formation.find(params[:id])
  end

  def update
    @formation = Formation.find(params[:id])

    if @formation.update(post_params)
      redirect_to @formation.promotion
    end
  end

  def next
    @formations = Formation
                    .includes(:promotion)
                    .order('promotions.annee ASC', mention: :asc)
    @formation = Formation.find(params[:id])
    @etudiants = @formation.etudiants.order(:nom, :prenom, :num_etudiant)
  end

  def transfert
    next_formation = Formation.find(params[:post][:next_formation])
    params[:post][:etudiant_ids].each do |etudiant_id|
      unless etudiant_id.empty?
        etudiant = Etudiant.find(etudiant_id)
        etudiant.transfert(next_formation)
      end
    end
  end

  def destroy
    formation = Formation.find(params[:id])
    promotion = formation.promotion
    formation.destroy

    redirect_to promotion
  end

  private

  def post_params
    params.require(:formation).permit(:mention, :libelle, :email, :code_ue, :promotion_id)
  end

end
