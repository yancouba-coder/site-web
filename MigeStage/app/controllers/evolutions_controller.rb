class EvolutionsController < ApplicationController
  def evolution
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

      @enteteTab = []
      @nbEntete = 0

      @filtre = 'tout'
      url = request.original_url
      if url.include? "filtre=" then
        uri    = URI.parse(url)
        params = CGI.parse(uri.query)
        @filtre = params['filtre'][0].to_s
      end

      if @filtre == 'tout' then
        if tuteur_universitaire_signed_in? then
          sqlevol = "SELECT stages.id, sujet, type_stage, nom, prenom, mention, raison_sociale " +
            " FROM stages, formations, promotions, etudiants, entreprises " +
            " WHERE tuteur_universitaire_id = " + idTuteur.to_s +
            " AND stages.formation_id = formations.id" +
            " AND formations.promotion_id = promotions.id" +
            " AND stages.etudiant_id = etudiants.id" +
            " AND stages.entreprise_id = entreprises.id " +
            " AND promotions.id = (SELECT MAX(promotions.id) FROM promotions)"
        else
          sqlevol = "SELECT stages.id, sujet, type_stage, nom, prenom, mention, raison_sociale " +
            " FROM stages, formations, promotions, etudiants, entreprises " +
            " WHERE stages.formation_id = formations.id" +
            " AND formations.promotion_id = promotions.id" +
            " AND stages.etudiant_id = etudiants.id" +
            " AND stages.entreprise_id = entreprises.id " +
            " AND promotions.id = (SELECT MAX(promotions.id) FROM promotions)"
        end
      else
        if tuteur_universitaire_signed_in? then
          sqlevol = "SELECT stages.id, sujet, raison_sociale, nom, prenom, mention, raison_sociale " +
            " FROM stages, formations, promotions, etudiants, entreprises " +
            " WHERE tuteur_universitaire_id = " + idTuteur.to_s +
            " AND stages.formation_id = formations.id" +
            " AND formations.promotion_id = promotions.id" +
            " AND stages.etudiant_id = etudiants.id" +
            " AND stages.entreprise_id = entreprises.id " +
            " AND formations.mention = '" + @filtre + "'" +
            " AND promotions.id = (SELECT MAX(promotions.id) FROM promotions)"
        else
          sqlevol = "SELECT stages.id, sujet, raison_sociale, nom, prenom, mention, raison_sociale " +
            " FROM stages, formations, promotions, etudiants, entreprises " +
            " WHERE stages.formation_id = formations.id" +
            " AND formations.promotion_id = promotions.id" +
            " AND stages.etudiant_id = etudiants.id" +
            " AND stages.entreprise_id = entreprises.id " +
            " AND formations.mention = '" + @filtre + "'" +
            " AND promotions.id = (SELECT MAX(promotions.id) FROM promotions)"
        end
      end
      evolutions = ActiveRecord::Base.connection.select_rows(sqlevol)
      i=0
      text = '{"etudiants":['
      evolutions.each do |evol|

        if(i>0)
          text += ','
        end
        text += '{"nom": "'+evol[3]+ ' '+evol[4] +'","promotion": "'+evol[5]+'", "entreprise": "'+evol[6]+'"'

        sqlgrille = "select contenu"+
          " from evaluations"+
          " WHERE stage_id = " +evol[0].to_s +
          " AND auto_evaluation = 0"+
          " AND finale =0"+
          " AND rempli =1"
        grilleExe = ActiveRecord::Base.connection.select_rows(sqlgrille)
        grille = '{}'
        if grilleExe.count != 0
          grille = grilleExe[0][0]
        end

        sqlgrillefinal = "select contenu"+
          " FROM evaluations"+
          " WHERE stage_id = " +evol[0].to_s+
          " AND auto_evaluation = 0"+
          " AND finale =1"+
          " AND rempli =1"
        grillefinalExe = ActiveRecord::Base.connection.select_rows(sqlgrillefinal)
        grillefinal = '{}'
        if grillefinalExe.count != 0
          grillefinal = grillefinalExe[0][0].to_s
        end


        tabEvolution = []
        if (grille!= '{}' && grillefinal!='{}')
          tabEvolution = algoComparaisonJson(JSON.parse(grille), JSON.parse(grillefinal))
        end

        text += ', "competences" : [{'
        y=0
        tabEvolution.each do |comptenceEvol|
          val = 3
          if comptenceEvol[1]>0
            val= 2
          else
            if comptenceEvol[1]<0
              val= 1
            end
          end
          if y>0
            text += ', '
          end
          text += '"'+comptenceEvol[0]+'": '+val.to_s
          y += 1
        end
        text += '}]}'

        i += 1
      end
      text += ']}'

      if @nbEntete == 0 then
        sqlFormatGrille = "select contenu"+
          " FROM ge_formats"+
          " WHERE id = (select MAX(id) FROM ge_formats)"
        formatGrille = ActiveRecord::Base.connection.select_rows(sqlFormatGrille)
        if formatGrille.count != 0
          jsonGrille = JSON.parse(formatGrille[0][0])
          sections = jsonGrille['sections']

          sections.each do |section|
            @enteteTab.append(section['titre'])
            @nbEntete += 1
          end
        end

      end

      @data = JSON.parse(text)
    end
  end


  def algoComparaisonJson (dataGrille, dataGrilleFinal)
    remplirEntete = false
    tabGrilleSelection = []
    if dataGrille.count != 0
      if (@enteteTab.length == 0)
        remplirEntete = true
      end
      dataGrille['sections'].each_with_index do |valueData, indexData|
        if (remplirEntete == true)
          @enteteTab.append(valueData['titre'])
          @nbEntete += 1
        end
        valueData['competences'].each do |valueComp|
          tabGrilleSelection.append([valueData['titre'], valueComp['selection']])
        end
      end
    end
    tabGrilleFinalSelection = []
    if dataGrilleFinal.count != 0
      dataGrilleFinal['sections'].each_with_index do |valueData, indexData|
        valueData['competences'].each do |valueComp|
          tabGrilleFinalSelection.append([valueData['titre'], valueComp['selection']])
        end
      end
    end

    sections = ''
    tabEvolution = []
    progression = 0
    indice = 0
    multipleSection = false
    for i in tabGrilleSelection
      if (sections != i[0])
        if (sections != '')
          tabEvolution.append([sections, progression])
        end
        multipleSection = true
        sections = i[0]
        progression = 0
      end

      if(i[1] < tabGrilleFinalSelection[indice][1])
        progression += 1
      else
        if(i[1] > tabGrilleFinalSelection[indice][1])
          progression -= 1
        end
      end
      indice +=1
    end

    if (multipleSection)
      tabEvolution.append([sections, progression])
    end

    return tabEvolution
  end
end