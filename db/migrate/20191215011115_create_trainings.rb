class CreateTrainings < ActiveRecord::Migration[5.2]
  def change
    create_table :trainings do |t|
      t.string :menu
      t.integer :weight
      t.integer :count
      t.integer :set
      t.references :tweet, foreign_key: true

      t.timestamps
    end
  end
end
