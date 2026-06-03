class CreateStudents < ActiveRecord::Migration[8.1]
  def change
    create_table :students do |t|
      t.text :name
      t.integer :grade
      t.text :term

      t.timestamps
    end
  end
end
