# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Promotion.create(annee: '2019')
Promotion.create(annee: '2020')
Promotion.create(annee: '2021')

Formation.create(mention: 'L3', libelle: 'L3 2019', email: 'licence3.2019@etu.u-bordeaux.fr', code_ue: 'UE4908', promotion_id: 1)