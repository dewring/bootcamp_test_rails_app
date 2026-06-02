class CreateRegistrations < ActiveRecord::Migration[8.1]
  def change
    create_table :registrations do |t|
      t.references :student
      t.references :school_class
      t.integer :point
      t.integer :booster

      t.timestamps
    end
  end
end
