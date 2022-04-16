class TuteurUniversitairesController < ApplicationController
  def index
    @tuteur_universitaires = TuteurUniversitaire.all.order(nom: :asc, prenom: :asc)
  end

  def new
    @tuteur_universitaire = TuteurUniversitaire.new
  end

  def edit
    @tuteur_universitaire = TuteurUniversitaire.find(params[:id])
  end

  def show
    @tuteur_universitaire = TuteurUniversitaire.find(params[:id])
  end

  def create
    @tuteur_universitaire = TuteurUniversitaire.create(tuteur_params)

    if @tuteur_universitaire.save
      redirect_to tuteur_universitaires_path
    end
  end

  def update
    @tuteur_universitaire = TuteurUniversitaire.find(params[:id])
    if @tuteur_universitaire.update(tuteur_params)
      redirect_to @tuteur_universitaire
    else
      render 'edit'
    end
  end

  def destroy
    tuteur_universitaire = TuteurUniversitaire.find(params[:id])
    tuteur_universitaire.destroy

    redirect_to tuteur_universitaires_path
  end

  private

  def tuteur_params
    params.require(:tuteur_universitaire).permit(:nom, :prenom, :alias, :email, :statut_encadrant, :fonction, :localisation)
  end

end
