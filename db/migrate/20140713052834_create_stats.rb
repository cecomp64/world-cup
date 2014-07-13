class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.string :title, null:false
      t.string :key, null:false

      t.timestamps
    end
  end
end
