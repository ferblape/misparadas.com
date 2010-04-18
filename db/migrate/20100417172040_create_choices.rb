class CreateChoices < ActiveRecord::Migration
  def self.up
    create_table :choices do |t|
      t.string :slug
      t.references :location

      t.timestamps
    end
  end

  def self.down
    drop_table :choices
  end
end
