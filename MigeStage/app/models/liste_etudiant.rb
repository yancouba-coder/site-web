require 'roo'
class ListeEtudiant < ApplicationRecord


  def self.import(file)
    accessible_attributes = ['num_etudiant','nom', 'prenom', 'email_universitaire','email_personnel', 'statut_arrivant_L3', 'mention','stage', 'alternance']
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      # next if user exists
      if ListeEtudiant.exists?(num_etudiant: row.to_hash['num_etudiant'])
        next
      else
        liste_etudiant = find_by_id(row["id"]) || new
        liste_etudiant.attributes = row.to_hash.slice(*accessible_attributes)
        liste_etudiant.save!
      end
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then CSV.new(file.path)
    when '.xls' then Roo::Excel.new(file.path, packed: nil, file_warning: :ignore)
    when '.xlsx' then Roo::Excelx.new(file.path, packed: nil, file_warning: :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end


end
