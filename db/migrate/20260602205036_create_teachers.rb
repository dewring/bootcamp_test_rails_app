class CreateTeachers < ActiveRecord::Migration[8.1]
  def change
    create_table :teachers do |t|
      t.text :name

      t.timestamps
    end
  end
end
