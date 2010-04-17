class CreateWaypoints < ActiveRecord::Migration
  def self.up
    create_table :waypoints do |t|
      t.integer :bus_route_id
      t.integer :bus_stop_id
      t.integer :section

      t.timestamps
    end
  end

  def self.down
    drop_table :waypoints
  end
end
