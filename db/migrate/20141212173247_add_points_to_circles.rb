class AddPointsToCircles < ActiveRecord::Migration
  def change
    add_column("circles", "location", :point, geographic: true)
  end
end
