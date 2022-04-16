class ProposalsController < ApplicationController
  def voir
    @proposal=Proposal.find(params[:id])
  end
  def new
    @proposal=Proposal.new;

  end
  def create
    @proposal = Proposal.new(proposal_params)
    @proposal.statut ="NON POURVU"
    if @proposal.save
      redirect_to @proposal
    else
      render :new
    end

  end

  def show
    @proposal = Proposal.find(params[:id])
    #@fichestage= FicheStage.find_by etudiant_id: 12 , note: 4
  end
  def visionner
    @proposal = Proposal.all.order('created_at DESC')
  end
  def publier
    #@etudiants =Etudiant.all
    # for @etu in @etudiants
    #      @etu.compteur=@etu.compteur +1
    #       @etu.save
  end
  def edit
    @proposal = Proposal.find(params[:id])
  end
  def changerstatut
    @proposal=Proposal.find(params[:id])
    @proposal.statut="POURVUE"
    @proposal.save
  end

  private
  def proposal_params
    params.require(:proposal).permit(
      :entreprise, :rh, :typecontrat, :email, :telephone,
      :adresse, :file, :description, :statut, :duree, :sujet, :technologie, :ville, :reference, :typecontrat )
  end

end
