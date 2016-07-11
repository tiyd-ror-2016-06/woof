class CreatePhones < ActiveRecord::Migration[5.0]
  def change
    create_table :phones do |t|
      t.belongs_to :user, foreign_key: true
      t.string :number

      t.timestamps
    end
  end
end
