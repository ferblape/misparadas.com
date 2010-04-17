class CreateBusRoutes < ActiveRecord::Migration
  def self.up
    create_table :bus_routes do |t|
      t.string :name
      t.string :terminal_a
      t.string :terminal_b
      t.integer :emt_id

      t.timestamps
    end
  end

  def self.down
    drop_table :bus_routes
  end
end
