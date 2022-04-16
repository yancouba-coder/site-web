class TableauDeBordController < ApplicationController
  def tableauDeBord
    require 'json'
    if !tuteur_universitaire_signed_in? && !responsable_stage_signed_in?
      redirect_to("/")
    else
      if tuteur_universitaire_signed_in?
        idTuteur = current_tuteur_universitaire.id
      else
        if responsable_stage_signed_in?
          idTuteur = current_responsable_stage.id
        end
      end

      require 'json'

      @filtre = 'tout'
      url = request.original_url
      if url.include? "filtre=" then
        uri    = URI.parse(url)
        params = CGI.parse(uri.query)
        @filtre = params['filtre'][0].to_s
      end

      if @filtre == 'tout' then
        if tuteur_universitaire_signed_in? then
          sqlStage =
            " SELECT stages.id, sujet, type_stage, nom, prenom, mention, raison_sociale " +
              " FROM stages, formations, promotions, etudiants, entreprises " +
              " WHERE tuteur_universitaire_id = " + idTuteur.to_s +
              " AND stages.formation_id = formations.id" +
              " AND formations.promotion_id = promotions.id" +
              " AND stages.etudiant_id = etudiants.id" +
              " AND stages.entreprise_id = entreprises.id " +
              " AND promotions.id = (SELECT MAX(promotions.id) FROM promotions)"
        else
          sqlStage =
            " SELECT stages.id, sujet, type_stage, nom, prenom, mention, raison_sociale " +
              " FROM stages, formations, promotions, etudiants, entreprises " +
              " WHERE stages.formation_id = formations.id" +
              " AND formations.promotion_id = promotions.id" +
              " AND stages.etudiant_id = etudiants.id" +
              " AND stages.entreprise_id = entreprises.id " +
              " AND promotions.id = (SELECT MAX(promotions.id) FROM promotions)"
        end
      else
        if tuteur_universitaire_signed_in? then
          sqlStage =
            " SELECT stages.id, sujet, type_stage, nom, prenom, mention, raison_sociale " +
              " FROM stages, formations, promotions, etudiants, entreprises " +
              " WHERE tuteur_universitaire_id = " + idTuteur.to_s +
              " AND stages.formation_id = formations.id" +
              " AND formations.promotion_id = promotions.id" +
              " AND stages.etudiant_id = etudiants.id" +
              " AND stages.entreprise_id = entreprises.id " +
              " AND formations.mention = '" + @filtre + "'" +
              " AND promotions.id = (SELECT MAX(promotions.id) FROM promotions)"
        else
          sqlStage =
            " SELECT stages.id, sujet, type_stage, nom, prenom, mention, raison_sociale " +
              " FROM stages, formations, promotions, etudiants, entreprises " +
              " WHERE stages.formation_id = formations.id" +
              " AND formations.promotion_id = promotions.id" +
              " AND stages.etudiant_id = etudiants.id" +
              " AND stages.entreprise_id = entreprises.id " +
              " AND formations.mention = '" + @filtre + "'" +
              " AND promotions.id = (SELECT MAX(promotions.id) FROM promotions)"
        end
      end

      @stages = ActiveRecord::Base.connection.select_rows(sqlStage)
      i = 0
      text = '{"etudiants":['

      @stages.each do |stage|
        autoEval  = 'null'
        autoEvalFinal = 'null'
        grille = 'null'
        grilleFinal = 'null'

        sqleval =
          "SELECT id,
        COUNT(CASE WHEN auto_evaluation = 1 THEN (CASE WHEN finale = 0 THEN id END)END) as autoEval,
        COUNT(CASE WHEN auto_evaluation = 1 THEN (CASE WHEN finale = 1 THEN id END)END) as autoEvalFinal,
        COUNT(CASE WHEN auto_evaluation = 0 THEN (CASE WHEN finale = 0 THEN id END)END) as grille,
        COUNT(CASE WHEN auto_evaluation = 0 THEN (CASE WHEN finale = 1 THEN id END)END) as grilleFinal
        FROM evaluations
        WHERE evaluations.stage_id = " + stage[0].to_s + "
        AND evaluations.rempli = 1"
        eval = ActiveRecord::Base.connection.select_rows(sqleval)

        sqlautoeval =
          "SELECT id
        FROM evaluations
        WHERE evaluations.stage_id = " + stage[0].to_s + "
        AND evaluations.auto_evaluation = 1
        AND evaluations.finale = 0"
        resautoeval = ActiveRecord::Base.connection.select_rows(sqlautoeval)
        idautoeval = 'null'
        if resautoeval.count != 0
          idautoeval = resautoeval[0][0].to_s
        end

        sqleval =
          "SELECT id
        FROM evaluations
        WHERE evaluations.stage_id = " + stage[0].to_s + "
        AND evaluations.auto_evaluation = 0
        AND evaluations.finale = 0"
        reseval = ActiveRecord::Base.connection.select_rows(sqleval)
        ideval = 'null'
        if reseval.count != 0
          ideval = reseval[0][0].to_s
        end

        sqlautoevalfinale =
          "SELECT id
        FROM evaluations
        WHERE evaluations.stage_id = " + stage[0].to_s + "
        AND evaluations.auto_evaluation = 1
        AND evaluations.finale = 1"
        resautoevalfinale = ActiveRecord::Base.connection.select_rows(sqlautoevalfinale)
        idautoevalfinale = 'null'
        if resautoevalfinale.count != 0
          idautoevalfinale = resautoevalfinale[0][0].to_s
        end

        sqlevalfinale =
          "SELECT id
        FROM evaluations
        WHERE evaluations.stage_id = " + stage[0].to_s + "
        AND evaluations.auto_evaluation = 0
        AND evaluations.finale = 1"
        resevalfinale = ActiveRecord::Base.connection.select_rows(sqlevalfinale)
        idevalfinale = 'null'
        if resevalfinale.count != 0
          idevalfinale = resevalfinale[0][0].to_s
        end

        sqlnote =
          "SELECT id
        FROM notations
        WHERE notations.stage_id = " + stage[0].to_s
        resnote = ActiveRecord::Base.connection.select_rows(sqlnote)
        idnote = 'null'
        if resnote.count != 0
          idnote = resnote[0][0].to_s
        end

        if eval.count != 0
          if (eval[0][0].to_s != 0)
            autoEval  = eval[0][1].to_s
          end
          if (eval[0][1].to_s != 0)
            autoEvalFinal = eval[0][2].to_s
          end
          if (eval[0][2].to_s != 0)
            grille = eval[0][3].to_s
          end
          if (eval[0][3] != 0)
            grilleFinal = eval[0][4].to_s
          end
        end

        sqlnotation = "SELECT COUNT(*) as note FROM notations WHERE notations.stage_id = " + stage[0].to_s + " AND notations.rempli = 1"
        notation = ActiveRecord::Base.connection.select_rows(sqlnotation)

        if notation.count == 0
          notation = 'null'
        else
          notation = notation[0][0].to_s
        end
        if(i>0)
          text += ','
        end
        text += '{"nom": "'+stage[3] +' '+ stage[4] +'","promotion": "'+stage[5]+'", "entreprise": "'+stage[6]+'", "type": "'+stage[2]+'", "autoevaluation": '+autoEval+', "grilleevaluation": '+grille+', "autoevaluationfinale": '+autoEvalFinal+', "grilleevaluationfinale": '+grilleFinal+',  "note": '+notation+', "idautoevaluation": '+idautoeval+', "idevaluation": '+ideval+', "idautoevaluationfinale": '+idautoevalfinale+', "idevaluationfinale": '+idevalfinale+', "idnote": '+idnote+'}'
        i += 1
      end
      text += ']}'

      @data = JSON.parse(text)
    end
  end
end