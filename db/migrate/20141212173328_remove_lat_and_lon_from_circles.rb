class RemoveLatAndLonFromCircles < ActiveRecord::Migration
  def change
    remove_column("circles", "latitude")
    remove_column("circles", "longitude")
  end
end
