class CreateAlerts < ActiveRecord::Migration[5.2]
  def change
    create_table :alerts do |t|
      t.references :user, foreign_key: true
      t.references :relationship, foreign_key: true
      t.references :favorite, foreign_key: true
      t.references :comment, foreign_key: true
      t.string :checked,default: "unread"

      t.timestamps
    end
  end
end
