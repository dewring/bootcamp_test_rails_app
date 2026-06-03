class CreateSchoolClasses < ActiveRecord::Migration[8.1]
  def change
    create_table :school_classes do |t|
      t.text :subject
      t.references :teacher

      t.timestamps
    end
  end
end
