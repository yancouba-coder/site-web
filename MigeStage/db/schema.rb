# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_04_13_201909) do

  create_table "active_storage_attachments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "aides", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.boolean "cv_recu"
    t.boolean "lettre_recu"
    t.string "suivi"
    t.boolean "present_reunion"
    t.bigint "etudiant_id"
    t.bigint "formation_id"
    t.index ["etudiant_id", "formation_id"], name: "index_aides_on_etudiant_id_and_formation_id", unique: true
    t.index ["etudiant_id"], name: "index_aides_on_etudiant_id"
    t.index ["formation_id"], name: "index_aides_on_formation_id"
  end

  create_table "disponibilites", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "nb_etudiants_souhaite"
    t.string "statut_reponse"
    t.bigint "tuteur_universitaire_id"
    t.bigint "formation_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "promotion_id"
    t.index ["formation_id"], name: "index_disponibilites_on_formation_id"
    t.index ["promotion_id"], name: "index_disponibilites_on_promotion_id"
    t.index ["tuteur_universitaire_id", "promotion_id"], name: "index_disponibilites_unique", unique: true
    t.index ["tuteur_universitaire_id"], name: "index_disponibilites_on_tuteur_universitaire_id"
  end

  create_table "entreprises", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "siren", limit: 14
    t.string "raison_sociale"
    t.string "ville"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "pays", default: "France"
    t.index ["siren"], name: "index_entreprises_on_siren", unique: true
  end

  create_table "etudiants", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "num_etudiant"
    t.string "nom"
    t.string "prenom"
    t.string "email_universitaire"
    t.string "email_personnel"
    t.string "statut_arrivant_L3", limit: 5
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "mention", limit: 250
    t.string "stage", limit: 250
    t.string "alternance", limit: 250
    t.bigint "tuteur_universitaires_id"
    t.bigint "tuteurid"
    t.index ["email"], name: "index_etudiants_on_email", unique: true
    t.index ["email_personnel"], name: "index_etudiants_on_email_personnel", unique: true
    t.index ["email_universitaire"], name: "index_etudiants_on_email_universitaire", unique: true
    t.index ["num_etudiant"], name: "index_etudiants_on_num_etudiant", unique: true
    t.index ["reset_password_token"], name: "index_etudiants_on_reset_password_token", unique: true
    t.index ["tuteur_universitaires_id"], name: "index_etudiants_on_tuteur_universitaires_id"
  end

  create_table "etudiants_formations", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "formation_id", null: false
    t.bigint "etudiant_id", null: false
    t.index ["etudiant_id"], name: "index_etudiants_formations_on_etudiant_id"
    t.index ["formation_id"], name: "index_etudiants_formations_on_formation_id"
  end

  create_table "evaluations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "contenu"
    t.boolean "auto_evaluation"
    t.bigint "stage_id"
    t.bigint "ge_format_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "finale"
    t.boolean "rempli"
    t.index ["ge_format_id"], name: "index_evaluations_on_ge_format_id"
    t.index ["stage_id"], name: "index_evaluations_on_stage_id"
  end

  create_table "fiche_stages", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "titre"
    t.string "type_stage"
    t.string "mention"
    t.date "date_debut"
    t.date "date_fin"
    t.string "statut"
    t.string "poste"
    t.string "taches"
    t.string "technologies"
    t.string "contact_nom"
    t.string "contact_prenom"
    t.string "contact_poste"
    t.string "tuteur_nom"
    t.string "tuteur_prenom"
    t.string "tuteur_fonction"
    t.string "tuteur_telephone"
    t.string "tuteur_email"
    t.string "entreprise_nom"
    t.string "entreprise_siren"
    t.string "entreprise_cp"
    t.string "entreprise_ville"
    t.string "entreprise_pays"
    t.string "commentaire_validation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "etudiant_id"
    t.decimal "compteur", precision: 10
    t.index ["etudiant_id"], name: "index_fiche_stages_on_etudiant_id"
  end

  create_table "formations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "mention"
    t.string "libelle"
    t.string "email"
    t.string "code_ue"
    t.bigint "promotion_id"
    t.index ["promotion_id"], name: "index_formations_on_promotion_id"
  end

  create_table "ge_formats", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "contenu"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "liste_etudiants", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nom"
    t.string "prenom"
    t.string "email_universitaire"
    t.string "email_personnel"
    t.string "statut_arrivant_L3"
    t.string "mention"
    t.string "stage"
    t.string "alternance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "num_etudiant"
    t.index ["num_etudiant"], name: "index_liste_etudiants_on_num_etudiant", unique: true
  end

  create_table "notation_formats", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "contenu"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "note"
    t.string "commentaire"
    t.bigint "stage_id"
    t.bigint "notation_format_id"
    t.boolean "rempli"
    t.index ["notation_format_id"], name: "fk_rails_6bdbda75c7"
    t.index ["stage_id"], name: "fk_rails_189801878e"
  end

  create_table "offres", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "titre"
    t.string "type_offre"
    t.string "lien_url"
    t.string "mention"
    t.binary "pdf"
    t.date "date_publication"
    t.string "sujet"
    t.bigint "entreprise_id"
    t.index ["entreprise_id"], name: "index_offres_on_entreprise_id"
  end

  create_table "offres_technologies", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "offre_id", null: false
    t.bigint "technology_id", null: false
    t.index ["offre_id"], name: "index_offres_technologies_on_offre_id"
    t.index ["technology_id"], name: "index_offres_technologies_on_technology_id"
  end

  create_table "promotions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "annee", limit: 4
    t.string "statut"
    t.index ["annee"], name: "index_promotions_on_annee", unique: true
  end

  create_table "proposals", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "description"
    t.string "rh"
    t.string "entreprise"
    t.string "typecontrat"
    t.string "email"
    t.string "telephone"
    t.string "adresse"
    t.string "lepdf"
    t.string "statut"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "duree"
    t.string "sujet"
    t.string "technologie"
    t.string "url"
    t.string "ville"
    t.string "reference"
  end

  create_table "responsable_stages", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nom"
    t.string "prenom"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.decimal "compteur", precision: 10
    t.index ["email"], name: "index_responsable_stages_on_email", unique: true
    t.index ["reset_password_token"], name: "index_responsable_stages_on_reset_password_token", unique: true
  end

  create_table "stages", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "sujet"
    t.date "date_ratification_convention"
    t.float "gratification"
    t.string "type_stage"
    t.string "commentaire"
    t.bigint "etudiant_id"
    t.bigint "formation_id"
    t.bigint "entreprise_id"
    t.bigint "tuteur_entreprise_id"
    t.bigint "tuteur_universitaire_id"
    t.index ["entreprise_id"], name: "index_stages_on_entreprise_id"
    t.index ["etudiant_id"], name: "index_stages_on_etudiant_id"
    t.index ["formation_id"], name: "index_stages_on_formation_id"
    t.index ["tuteur_entreprise_id"], name: "index_stages_on_tuteur_entreprise_id"
    t.index ["tuteur_universitaire_id"], name: "index_stages_on_tuteur_universitaire_id"
  end

  create_table "technologies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "tag"
    t.index ["tag"], name: "index_technologies_on_tag", unique: true
  end

  create_table "tuteur_entreprises", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nom"
    t.string "prenom"
    t.string "email"
    t.string "telephone", limit: 10
    t.bigint "entreprise_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["entreprise_id"], name: "index_tuteur_entreprises_on_entreprise_id"
  end

  create_table "tuteur_universitaires", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nom"
    t.string "prenom"
    t.string "alias"
    t.string "email"
    t.string "statut_encadrant"
    t.string "fonction"
    t.string "localisation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_tuteur_universitaires_on_email", unique: true
    t.index ["reset_password_token"], name: "index_tuteur_universitaires_on_reset_password_token", unique: true
  end

  create_table "visites", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "date"
    t.string "statut"
    t.boolean "relance"
    t.string "commentaire"
    t.bigint "stage_id"
    t.index ["stage_id"], name: "index_visites_on_stage_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "aides", "etudiants"
  add_foreign_key "aides", "formations"
  add_foreign_key "disponibilites", "promotions"
  add_foreign_key "etudiants", "liste_etudiants", column: "num_etudiant", primary_key: "num_etudiant", name: "etudiants_ibfk_1", on_update: :cascade, on_delete: :nullify
  add_foreign_key "etudiants", "tuteur_universitaires", column: "tuteur_universitaires_id"
  add_foreign_key "evaluations", "ge_formats"
  add_foreign_key "evaluations", "stages"
  add_foreign_key "fiche_stages", "etudiants"
  add_foreign_key "formations", "promotions"
  add_foreign_key "notations", "notation_formats"
  add_foreign_key "notations", "stages"
  add_foreign_key "offres", "entreprises"
  add_foreign_key "stages", "entreprises"
  add_foreign_key "stages", "etudiants"
  add_foreign_key "stages", "formations"
  add_foreign_key "stages", "tuteur_entreprises"
  add_foreign_key "stages", "tuteur_universitaires"
  add_foreign_key "tuteur_entreprises", "entreprises"
  add_foreign_key "visites", "stages"
end
