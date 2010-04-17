class CreateChoices < ActiveRecord::Migration
  def self.up
    create_table :choices do |t|
      t.string :slug
      t.integer :bus_stop_id
      t.integer :waypoint_id

      t.timestamps
    end
  end

  def self.down
    drop_table :choices
  end
end
