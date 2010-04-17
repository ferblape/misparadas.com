namespace :db_import do
  desc 'Import bus stops from DATABASE'
  task :bus_stops => :environment do
    require 'sqlite3'

    db = SQLite3::Database.new(File.join(Rails.root, 'db', 'emt.sqlite'))
    BusStop.destroy_all
    db.execute("select * from BUSSTOP").each do |row|
      puts row.inspect
      begin
        BusStop.create! :emt_id => row[0], 
                        :name => row[1], 
                        :latitude => row[2].to_f, :longitude => row[3].to_f
      rescue
        puts "#{$!}"
      end
    end
  end
end
