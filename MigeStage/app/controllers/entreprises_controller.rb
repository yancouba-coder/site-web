class EntreprisesController < ApplicationController
  def index
    @entreprises = Entreprise.all.order(raison_sociale: :asc)
  end

  def show
    @entreprise = Entreprise.find(params[:id])
  end

  def new
    @entreprise = Entreprise.new
  end

  def create
    @entreprise = Entreprise.new(post_params)

    if @entreprise.save
      redirect_to entreprises_path
    else
      puts @entreprise.errors.full_messages_for(:siren)
    end
  end

  def edit
    @entreprise = Entreprise.find(params[:id])
  end

  def update
    @entreprise = Entreprise.find(params[:id])

    if @entreprise.update(post_params)
      redirect_to entreprises_path
    end
  end

  def destroy
    entreprise = Entreprise.find(params[:id])
    entreprise.destroy

    redirect_to entreprises_path
  end

  private

  def post_params
    params.require(:entreprise).permit(:siren, :raison_sociale, :ville, :pays)
  end

end
