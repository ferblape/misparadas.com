namespace :emt do
  
  desc 'Import bus stop data from emt.sqlite database'
  task :import_bus_stops => :environment do
    require 'sqlite3'

    db = SQLite3::Database.new(File.join(Rails.root, 'db', 'emt.sqlite'))
    Location.destroy_all
    Line.destroy_all
    Route.destroy_all
    db.execute("select * from BUSSTOP").each do |row|
      puts row.inspect
      begin
        location = Location.create! :emt_code => row[0], :name => row[1], :lat => row[2].to_f, :lng => row[3].to_f
        [row[4].split(' '), row[5].split(' ')].transpose.each do |pair|
          direction = ((pair.last[-1..-1] == '1') ? "normal" : "reverse")
          emt_line =  pair.last[0..-3]
          line = Line.find_or_create_by_name(pair.first)
          puts "\t #{line.name} [#{direction} direction]"
          route = Route.find_or_create_by_line_id_and_direction(line.id, direction)
          atts = {:emt_line => emt_line}
          db.execute("select * from LINE where numberBusLine = #{row[0]}").each do |row2|
            direction == "normal" ? atts.merge!({:origin => row2[4], :destination => row2[5]}) : atts.merge!({:origin => row2[5], :destination => row2[4]})
          end
          route.update_attributes(atts)
          location.routes << route
        end
      rescue
        puts "#{$!}"
      end
    end
  end
  
  desc 'Syncs EMT lines information against our database'
  task :sync_lines => :environment do
    # Get lines from EMT
    url = URI.parse(AppConfig.urls.lines)
    doc = Hpricot.XML(Net::HTTP.get(url))
    emt_lines = (doc/:REG).map do |line| 
      # ignore lines EMT
      next if (line/:Label).inner_html == "EMT" 
      {
        :name => (line/:Label).inner_html, 
        :emt_line => (line/:Line).inner_html,
        :name_a => (line/:NameA).inner_html,
        :name_b => (line/:NameB).inner_html,
      }
    end.compact
    
    lines_names = emt_lines.map{ |h| h[:name] }
    names = Line.all.map(&:name)
    
    # non existing lines in local
    not_existing_in_local = lines_names - names
    # non existin lines in remote, but in local
    not_existing_in_remote = names - lines_names
    
    not_existing_in_local.each do |name|
      emt_line = emt_lines.select{ |emt_line| emt_line[:name] == name }.first
      puts "Creating line: #{emt_line[:name]}"
      line = Line.create :name => emt_line[:name]

      # Get routes from this line
      url = URI.parse(AppConfig.urls.routes % emt_line[:emt_line])
      doc = Hpricot.XML(Net::HTTP.get(url))

      remote_routes = (doc/:REG).map do |remote_route| 
        normal = (remote_route/:SecDetail).inner_html == '10' ? true : false
        {
          :direction => normal ? 'normal' : 'reverse',
          :name => (remote_route/:Name).inner_html, 
          :emt_code => (remote_route/:Node).inner_html,
          :emt_line => emt_line[:emt_line],
          :origin => normal ? emt_line[:name_a] : emt_line[:name_b],
          :destination => normal ? emt_line[:name_b] : emt_line[:name_a]
        }
      end.compact
      
      # Create routes for the line
      remote_routes.each do |remote_route|        
        emt_code = remote_route.delete(:emt_code)
        route = line.routes.create remote_route
        puts "  creating route: #{route.name}"
        begin
          Location.find_by_emt_code(emt_code).routes << route
        rescue
          puts "Location #{emt_code} - #{$!}"
        end
      end
    end

    puts
    puts
    not_existing_in_remote.each do |line_name|
      if line = Line.find_by_name(line_name)
        line.destroy
        puts "Removing line: #{line_name}"
      end
    end
  end
  
end