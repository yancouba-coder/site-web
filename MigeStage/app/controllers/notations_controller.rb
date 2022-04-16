class NotationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def notation
    if !tuteur_universitaire_signed_in? && !responsable_stage_signed_in? && !etudiant_signed_in?
      redirect_to("/")
    else
      require 'json'
      params.require(:id)
      @id = params[:id]
      notationDB = Notation.find(@id)
      text = NotationFormats.find(notationDB.notation_format_id).contenu
      @data = JSON.parse(text)

      sqlevol = "SELECT nom, prenom, mention, libelle, raison_sociale " +
        " FROM stages, etudiants, entreprises, formations " +
        " WHERE stages.id = " + notationDB.stage_id.to_s +
        " AND etudiants.id = stages.etudiant_id" +
        " AND entreprises.id = stages.entreprise_id" +
        " AND formations.id = stages.formation_id"

      notationData = JSON.parse ActiveRecord::Base.connection.select_rows(sqlevol)[0].to_s.gsub("=>", ":")

      @nomEtudiant = notationData[0].to_s + " " + notationData[1].to_s
      @promotionEtudiant = notationData[2].to_s + " " + notationData[3].to_s
      @entrepriseEtudiant = notationData[4].to_s

      @note = notationDB.note
      @commentaire = notationDB.commentaire
    end

  end

  def viewNotation
    if !tuteur_universitaire_signed_in? && !responsable_stage_signed_in? && !etudiant_signed_in?
      redirect_to("/")
    else
      require 'json'
      params.require(:id)
      @id = params[:id]
      notationDB = Notation.find(@id)
      text = NotationFormats.find(notationDB.notation_format_id).contenu
      @data = JSON.parse(text)

      sqlevol = "SELECT nom, prenom, mention, libelle, raison_sociale " +
        " FROM stages, etudiants, entreprises, formations " +
        " WHERE stages.id = " + notationDB.stage_id.to_s +
        " AND etudiants.id = stages.etudiant_id" +
        " AND entreprises.id = stages.entreprise_id" +
        " AND formations.id = stages.formation_id"

      notationData = JSON.parse ActiveRecord::Base.connection.select_rows(sqlevol)[0].to_s.gsub("=>", ":")

      @nomEtudiant = notationData[0].to_s + " " + notationData[1].to_s
      @promotionEtudiant = notationData[2].to_s + " " + notationData[3].to_s
      @entrepriseEtudiant = notationData[4].to_s

      @note = notationDB.note
      @commentaire = notationDB.commentaire
    end

  end

  def saveNotation
    if !tuteur_universitaire_signed_in? && !responsable_stage_signed_in? && !etudiant_signed_in?
      redirect_to("/")
    else
      require 'json'
      puts params
      params.require(:note)
      params.require(:id)
      params.require(:commentaire)
      valid_params = true
      if (valid_params)
        @note = params[:note]
        @commentaire = params[:commentaire]
        @id = params[:id]
        data =  Notation.find(@id)
        if (data != nil)
          st = ActiveRecord::Base.connection.raw_connection.prepare("update notations set note=?, commentaire=? where id=?")
          st.execute(@note, @commentaire, @id)
          st.close
          redirect_to action: "viewNotation", id: @id
        end
      end
    end

  end

  def template
    if !tuteur_universitaire_signed_in? && !responsable_stage_signed_in? && !etudiant_signed_in?
      redirect_to("/")
    else
      sqlFormatNotation = "select contenu"+
        " FROM notation_formats"+
        " WHERE id = (select MAX(id) FROM notation_formats)"
      formatNotation = ActiveRecord::Base.connection.select_rows(sqlFormatNotation)

      @jsonGrille = []
      if formatNotation.count != 0
        @jsonGrille = JSON.parse(formatNotation[0][0])
      end

    end
  end
end