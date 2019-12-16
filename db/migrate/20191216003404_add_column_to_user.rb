class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :image, :string
    add_column :users, :profile, :string
    add_column :users, :age, :integer
    add_column :users, :weight, :integer
    add_column :users, :sex, :string
    add_column :users, :training_years, :integer
  end
end
