class CangeDataCheckedToAlert < ActiveRecord::Migration[5.2]
  def change
    change_column :alerts, :checked, :integer, default: 0
  end 
end
