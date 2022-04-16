class ListeEtudiantsController < ApplicationController
  before_action :set_liste_etudiant, only: %i[ show edit update destroy ]

  # GET /liste_etudiants or /liste_etudiants.json
  def index
    @liste_etudiants = ListeEtudiant.all
  end

  # GET /liste_etudiants/1 or /liste_etudiants/1.json
  def show
  end

  # GET /liste_etudiants/new
  def new
    @liste_etudiant = ListeEtudiant.new
  end

  # GET /liste_etudiants/1/edit
  def edit
  end

  # POST /liste_etudiants or /liste_etudiants.json
  def create
    @liste_etudiant = ListeEtudiant.new(liste_etudiant_params)

    respond_to do |format|
      if @liste_etudiant.save
        format.html { redirect_to @liste_etudiant, notice: "Etudiant crée avec succès." }
        format.json { render :show, status: :created, location: @liste_etudiant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @liste_etudiant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /liste_etudiants/1 or /liste_etudiants/1.json
  def update
    respond_to do |format|
      if @liste_etudiant.update(liste_etudiant_params)
        format.html { redirect_to @liste_etudiant, notice: "Etudiant Modifier avec succès." }
        format.json { render :show, status: :ok, location: @liste_etudiant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @liste_etudiant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /liste_etudiants/1 or /liste_etudiants/1.json
  def destroy
    @liste_etudiant.destroy
    respond_to do |format|
      format.html { redirect_to liste_etudiants_url, notice: "Etudiant supprimé avec succès." }
      format.json { head :no_content }
    end
  end

  def import
    ListeEtudiant.import (params[:file])
    redirect_to liste_etudiants_path, notice: "Etudiants ajoutés avec succès"
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_liste_etudiant
      @liste_etudiant = ListeEtudiant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def liste_etudiant_params
      params.require(:liste_etudiant).permit(:num_etudiant, :nom, :prenom, :email_universitaire, :email_personnel, :statut_arrivant_L3, :mention, :stage, :alternance)
    end
end
