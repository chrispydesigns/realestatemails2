require 'csv'

namespace :reemails do 
 
  namespace :data do
    # Call as rake reemails:data:load_realtors[my_file_name]
    task :load_realtors, [:filename] => :environment do |t, args|
      puts "FILE: #{args.filename}"
      CSV.foreach(args.filename, headers: true) do |row|
        h = row.to_hash
	h['affiliation'] = h.delete('association')
      	Realtor.create!(h)
      end      
    end
  end

end
