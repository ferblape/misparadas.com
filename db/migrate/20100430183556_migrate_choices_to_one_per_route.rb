class MigrateChoicesToOnePerRoute < ActiveRecord::Migration
  def self.up
    Choice.find(:all, :conditions => {:favourite_route_id => nil}).each do |choice|
      choice.location.routes.each do |route|
        puts "Adding new Choice for Route #{route.id}"
        Choice.create!(:slug => choice.slug, :favourite_route_id => route.id, :location_id => choice.location)
      end
      choice.destroy
    end
  
  end

  def self.down
  end
end
