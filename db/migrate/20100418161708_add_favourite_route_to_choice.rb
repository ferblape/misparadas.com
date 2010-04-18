class AddFavouriteRouteToChoice < ActiveRecord::Migration
  def self.up
    add_column :choices, :favourite_route_id, :integer
  end

  def self.down
    remove_column :choices, :favourite_route_id
  end
end
