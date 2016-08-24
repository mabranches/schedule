class CreateSchedulings < ActiveRecord::Migration[5.0]
  def change
    create_table :schedulings do |t|
      t.date :day
      t.integer :hour
      t.integer :lock_version
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :schedulings, :day
    add_index :schedulings, [:day, :hour], unique: true
  end
end
