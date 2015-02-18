class CreateRealtors < ActiveRecord::Migration
  def change
    create_table :realtors do |t|
      t.string :emai
      t.string :sic_code
      t.string :sic_code_description
      t.string :naics_code
      t.string :company_name
      t.string :contact_name
      t.string :first_name
      t.string :last_name
      t.string :title
      t.string :designations
      t.string :agency
      t.string :MSA
      t.string :license_type
      t.string :license_number
      t.string :license_issued
      t.string :license_expires
      t.string :address
      t.string :address2
      t.string :city
      t.string :county
      t.string :state
      t.string :zip
      t.string :phone
      t.string :fax
      t.string :company_website
      t.string :revenue
      t.string :employees
      t.string :affiliation

      t.timestamps
    end
  end
end
