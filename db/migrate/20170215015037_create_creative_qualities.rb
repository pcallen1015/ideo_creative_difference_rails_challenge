class CreateCreativeQualities < ActiveRecord::Migration[5.0]
  def change
    create_table :creative_qualities do |t|
      t.string :name
      t.text :description
      t.string :color, default: 'default'

      t.timestamps
    end
  end
end
