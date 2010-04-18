class AddOriginToRoutes < ActiveRecord::Migration
  def self.up
    add_column :routes, :origin, :string
  end

  def self.down
    remove_column :routes, :origin
  end
end
