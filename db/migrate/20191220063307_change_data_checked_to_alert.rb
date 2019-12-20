class ChangeDataCheckedToAlert < ActiveRecord::Migration[5.2]
  def change
    change_column :alerts, :checked, :boolean, default: false, null: false
  end
end
