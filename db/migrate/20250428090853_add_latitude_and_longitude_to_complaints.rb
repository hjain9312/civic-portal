class AddLatitudeAndLongitudeToComplaints < ActiveRecord::Migration[7.2]
  def change
    add_column :complaints, :latitude, :float
    add_column :complaints, :longitude, :float
  end
end
