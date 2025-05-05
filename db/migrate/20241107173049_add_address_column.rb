class AddAddressColumn < ActiveRecord::Migration[7.2]
  def change
    add_column :complaints, :address, :string
  end
end
