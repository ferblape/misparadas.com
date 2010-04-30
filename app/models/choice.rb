class Choice < ActiveRecord::Base
  belongs_to :location
  belongs_to :favourite_route, :class_name => 'Route'
  
  private
  def self.generate_slug
    slug = rand(36**8).to_s(36).rjust(8,'0')
    
    until Choice.find_by_slug(slug).blank?
      slug = rand(36**8).to_s(36).rjust(8,'0')
    end
    return slug
  end
end
