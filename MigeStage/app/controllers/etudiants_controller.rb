class EtudiantsController < ApplicationController

  def index
    #@etudiants = Etudiant.order(:nom, :prenom, :num_etudiant)
    @etudiants = ListeEtudiant.find_by_sql("SELECT * FROM liste_etudiants WHERE email_universitaire IN(select email_universitaire from etudiants);")

  end

  def new
    @etudiant = Etudiant.new
  end
  #On n'inscrit pas l'étudiant tant qu'il n'existe pas déjà dans la base de donnée
  def create

      @etudiant = Etudiant.new(post_params)
      if @etudiant.save # à changer car il faut juste mettre le flag inscrit à true.
      redirect_to etudiants_path
      end
  end

  def edit
    @etudiant = Etudiant.find(params[:id])
  end

  def update
    @etudiant = Etudiant.find(params[:id])

    if @etudiant.update(post_params)
      redirect_to etudiants_path
    end
  end

  #this function show is used to disconnect
  def show
    session.destroy
    redirect_to :root
  end
  def destroy
    etudiant = Etudiant.find(params[:id])
    etudiant.destroy

    redirect_to etudiants_path
  end
  def changer_tuteur
    @fichestage= FicheStage.find(params[:id])
    @etudiant=Etudiant.find @fichestage.etudiant_id
    @etudiant.tuteur_universitaires_id=params[:etudiant][:tuteur_universitaires_id]
    @etudiant.save


  end
  def ajrapport
    @etudiant=current_etudiant
    render :rapport
  end
  def misajourd
    @etu.update(post_params)

  end
  def post_params
    params.require(:etudiant).permit(:num_etudiant,:rapport, :nom, :prenom, :email_universitaire,:tuteurid, :email_personnel, :statut_arrivant_L3, :formation_ids, :tuteur_universitaires_id)
  end

end
