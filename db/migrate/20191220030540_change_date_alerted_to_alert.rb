class ChangeDateAlertedToAlert < ActiveRecord::Migration[5.2]
  def change
    change_column :alerts, :alerted, :bigint
  end
end
