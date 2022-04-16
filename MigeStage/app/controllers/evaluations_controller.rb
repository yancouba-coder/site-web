class EvaluationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def evaluation


    if !tuteur_universitaire_signed_in? && !etudiant_signed_in? && !responsable_stage_signed_in?
      redirect_to("/")
    else
      # téléchargement d'une évaluation
      if params.has_key?('id') then
        sql = "Select * from evaluations where id = " + params[:id]
        res = ActiveRecord::Base.connection.select_rows(sql)
        # téléchargement du template
      else
        sql = "Select * from ge_formats ORDER BY id DESC LIMIT 1 "
        res = ActiveRecord::Base.connection.select_rows(sql)
      end

      if res.count != 0
        @data = JSON.parse(res[0][1])
      else
        @data = ""
      end

      respond_to do |format|
        format.html
        format.pdf do
          pdf = ConsultationEval.new(@data)
          # pdf = Prawn::Document.new
          # pdf.text "Hello"
          send_data pdf.render, filename: 'member.pdf', type: 'application/pdf', disposition: "inline"
        end
      end
    end

  end

  def save
    if !tuteur_universitaire_signed_in? && !etudiant_signed_in? && !responsable_stage_signed_in?
      redirect_to("/")
    else
      sql = "Select * from ge_formats ORDER BY id DESC LIMIT 1 "
      @res = ActiveRecord::Base.connection.select_rows(sql)

      @text_json = JSON.parse(@res[0][1])

      params.delete('action')
      params.delete('controller')

      params.each do |key, value|
        if @text_json.key?(key)
          @text_json[key] = params[key]
        else
          @text_json['sections'].each_with_index do |value_data, index_data|
            value_data['competences'].each_with_index do |value_comp, index_comp|
              if value_comp['intitule'] == key
                @text_json['sections'][index_data]['competences'][index_comp]['selection'] = value.to_i
              end
            end
          end
        end
      end

      sql = "Update evaluations set contenu = " +"'" + @text_json.to_json + "', rempli = 1 where id = " + params[:id]
      ActiveRecord::Base.connection.execute(sql)
      redirect_to action: "viewEvaluation", id: params[:id]
    end
  end

  def viewEvaluation
    if !tuteur_universitaire_signed_in? && !etudiant_signed_in? && !responsable_stage_signed_in?
      redirect_to("/")
    else
      if params[:id] == nil
        redirect_to(evaluation_path)
      else
        sql = "Select * from evaluations where id = " + params[:id]
        res = ActiveRecord::Base.connection.select_rows(sql)

        if res.count != 0
            if res[0][2] == 1
              if res[0][7] == 1
                @typeEval = "Visualisation de la fiche d'auto-évaluation finale"
              else
                @typeEval = "Visualisation de la fiche d'auto-évaluation"
              end
            else
              if res[0][7] == 1
                @typeEval = "Visualisation de la fiche d'évaluation finale"
              else
                @typeEval = "Visualisation de la fiche d'évaluation"
              end
            end
            @data = JSON.parse(res[0][1])

        end
      end

      respond_to do |format|
        format.html
        format.pdf do
          pdf = ConsultationEval.new(@data)
          # pdf = Prawn::Document.new
          # pdf.text "Hello"
          send_data pdf.render, filename: 'grille.pdf', type: 'application/pdf', disposition: "inline"
        end
      end
    end

  end

  def editEvaluation
    if !tuteur_universitaire_signed_in? && !etudiant_signed_in? && !responsable_stage_signed_in?
      redirect_to("/")
    else
      if params[:id] == nil
        redirect_to(evaluation_path)
      else
        @url_save = "/evaluation/save/" + params[:id]
        sql = "Select * from evaluations where id = " + params[:id]
        res = ActiveRecord::Base.connection.select_rows(sql)
      end

      if res.count != 0
        if res[0][8] == 1
          redirect_to action: "viewEvaluation", id: params[:id]
        else
          if res[0][2] == 1
            if res[0][7] == 1
              @typeEval = "Remplissage de la fiche d'auto-évaluation finale"
            else
              @typeEval = "Remplissage de la fiche d'auto-évaluation"
            end
          else
            if res[0][7] == 1
              @typeEval = "Remplissage de la fiche d'évaluation finale"
            else
              @typeEval = "Remplissage de la fiche d'évaluation"
            end
          end
          @data = JSON.parse(res[0][1])
        end
      end

      respond_to do |format|
        format.html
        format.pdf do
          pdf = ConsultationEval.new(@data)
          # pdf = Prawn::Document.new
          # pdf.text "Hello"
          send_data pdf.render, filename: 'grille.pdf', type: 'application/pdf', disposition: "inline"
        end
      end
    end

  end

  def template
    if !tuteur_universitaire_signed_in? && !etudiant_signed_in? && !responsable_stage_signed_in?
      redirect_to("/")
    else
      sqlFormatGrille = "select contenu"+
        " FROM ge_formats"+
        " WHERE id = (select MAX(id) FROM ge_formats)"
      formatGrille = ActiveRecord::Base.connection.select_rows(sqlFormatGrille)
      @jsonGrille = []
      if formatGrille.count != 0
        @jsonGrille = JSON.parse(formatGrille[0][0])
      end

    end


  end
end