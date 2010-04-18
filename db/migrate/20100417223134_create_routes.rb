class CreateRoutes < ActiveRecord::Migration
  def self.up
    create_table :routes do |t|
      t.string :destination
      t.references :line
      t.string :name
      
      t.string :emt_line
      t.string :direction
      
      t.timestamps
    end
  end

  def self.down
    drop_table :routes
  end
end
