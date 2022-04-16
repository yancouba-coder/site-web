class PromotionsController < ApplicationController
  def index
    @promotions = Promotion.all.order(annee: :desc)
  end

  def show
    @promotion = Promotion.find(params[:id])
    @formation = Formation.new(promotion_id: @promotion.id)
  end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(post_params)
    @promotion.statut = Promotion.statuts[:OUVERTE]

    if @promotion.save
      redirect_to promotions_path
    else
      puts @promotion.errors.full_messages_for(:annee)
    end
  end

  def destroy
    promotion = Promotion.find(params[:id])
    promotion.destroy

    redirect_to promotions_path
  end

  def close
    promotion = Promotion.find(params[:id])
    promotion.cloturer

    redirect_to promotions_path
  end

  private

  def post_params
    params.require(:promotion).permit(:annee)
  end

end
