class Realtor < ActiveRecord::Base
  extend Displayable

  def self.display_columns
    temp_display_columns.delete_if do
      |v| 
      ['id', 'created_at', 'updated_at', 'sic_code', 'sic_code_description', 
       'naics_code', 'company_name', 'designations', 'agency', 'MSA', 'license_type', 
       'license_number', 'license_issued', 'license_expires', 'address', 'address2', 
       'county', 'phone', 'zip', 'fax', 'company_website', 'revenue', 'employees', 'affiliation'
      ].include?(v.to_s) 
    end     
  end

  def self.display_column_index
    h = Hash[column_names.map.with_index.to_a]
    h.except! display_columns
  end

end

