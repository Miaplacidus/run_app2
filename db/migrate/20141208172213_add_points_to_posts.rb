class AddPointsToPosts < ActiveRecord::Migration
  def change
    add_column("posts", "location", :point, geographic: true)
  end
end
