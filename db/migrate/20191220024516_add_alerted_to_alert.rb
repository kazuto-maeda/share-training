class AddAlertedToAlert < ActiveRecord::Migration[5.2]
  def change
    add_column :alerts, :alerted, :integer
  end
end
