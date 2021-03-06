class ChangeDataTypeForVaccine < ActiveRecord::Migration[6.0]
  def change
    change_column :vaccines, :description, :text
  end
end
