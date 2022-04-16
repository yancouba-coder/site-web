class FicheStagesController < ApplicationController
  def index
    # @fichestage = FicheStage.all
    #@fichestage=FicheStage.find_by_sql("SELECT f.* from fiche_stages f, etudiants e where f.etudiant_id=e.id")
    #@idety=current_etudiant.id
    @fichestage = FicheStage.all
    #@fichestage=FicheStage.find_by etudiant_id: @idety
    @fichestage_todo = FicheStage.where(statut: "EN_ATTENTE_DE_VALIDATION")
    @fichestage_draft = FicheStage.where(statut: "BROUILLON")
  end

  def show
    @fichestage = FicheStage.find(params[:id])
    #@fichestage= FicheStage.find_by etudiant_id: 12 , note: 4
  end
  def hisfiche
    @fichestage=FicheStage.where(etudiant_id: current_etudiant.id)
    #@fichestage = FicheStage.find(:all, :condition=>['etudiant_id=?',current_etudiant.id] )
  end

  def new
    @fichestage = FicheStage.new
  end

  def create
    @fichestage = FicheStage.new(fiche_stage_params)

    @fichestage.statut = "EN_ATTENTE_DE_VALIDATION"
    @fichestage.etudiant_id = current_etudiant.id

    if @fichestage.save
      redirect_to @fichestage
    else
      render :new
    end
  end
  ###### Cette fonction doit etre changé
  def ajouterfiche
    @res = ResponsableStage.where(email: "yancoubadiatta25@gmail.com")
    @res.compteur=@res.compteur +1
    @res.save
  end
  def csend
    #@fichestage = FicheStage.new(fiche_stage_params)
    @fichestage=FicheStage.find_by etudiant_id: current_etudiant.id
    @fichestage.statut = "EN_ATTENTE_DE_VALIDATION"
    @fichestage.etudiant_id = current_etudiant.id

    if @fichestage.save
      redirect_to @fichestage
    else
      render :new
    end
  end

  def edit
    @fichestage = FicheStage.find(params[:id])
  end

  def update
    @fichestage = FicheStage.find(params[:id])
    if @fichestage.statut == "REFUSEE"
      @fichestage.statut = "BROUILLON"
    end

    if @fichestage.update(fiche_stage_params)
      redirect_to @fichestage
    else
      render :show
    end
  end

  def usend
    @fichestage = FicheStage.find(params[:id])

    if @fichestage.update(statut: "EN_ATTENTE_DE_VALIDATION")
      redirect_to @fichestage
    else
      render :show
    end
  end

  def validate
    @fichestage = FicheStage.find(params[:id])
    #@fichestage = FicheStage.find(6)
    #@fichestage = FicheStage.find_by statut: "EN ATTENTE DE VALIDATION"
    #@fichestage = FicheStage.all
  end
  def cvalidee
    @fichestage = FicheStage.find(params[:id])
    @fichestage.statut="VALIDEE"
    @fichestage.save
  end
  def crefusee
    @fichestage = FicheStage.find(params[:id])
    @fichestage.statut="REFUSEE"
    @fichestage.save

  end
  def envoyer_fiche
    @fichestage=FicheStage.create
    @fichestage.statut="EN_ATTENTE_DE_VALIDATION"
    @fichestage.save
    #cette ligne doit changer il faut enlever le mail et considérer juste l'ID
    #res = ResponsableStage.where(email: "yancouba.diatta@gmail.com").first
    res=ResponsableStage.find(6)
    res.increment!(:compteur, 1)#ici on incrémente le nombre de fiche si l'étudiant clique sur envoyer
                                #find (6) c'est pour faire un sorte que le compte du responsable des stages ne soit pas n'importe qui
  end
  def liste_a_valider
    @fichestage = FicheStage.all.order("statut ASC")
  end
  def vyes
    @fichestage = FicheStage.find(params[:id])
    @fichestage.statut = "VALIDEE"

    if @fichestage.update(fiche_stage_params)
      redirect_to @fichestage
    else
      render :validate
    end
  end


  def vno
    @fichestage = FicheStage.find(params[:id])
    @fichestage.statut = "REFUSEE"

    if @fichestage.update(fiche_stage_params)
      redirect_to @fichestage
    else
      render :validate
    end
  end

  private
  def fiche_stage_params
    params.require(:fiche_stage).permit(
      :titre, :type_stage, :mention, :date_debut, :date_fin,
      :poste, :taches, :technologies, :contact_nom, :contact_prenom, :contact_poste,
      :tuteur_nom, :tuteur_prenom, :tuteur_fonction, :tuteur_telephone, :tuteur_email,
      :entreprise_nom, :entreprise_siren, :entreprise_cp, :entreprise_ville, :entreprise_pays, :commentaire_validation)
  end

  def destroy
    #@fichestage = fiche_stages.all
  end


end
