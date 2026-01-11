class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.boolean :completed
      t.string :external_user_name
      t.string :external_company
      t.string :external_city

      t.timestamps
    end
  end
end
