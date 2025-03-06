class CreateSocialLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :social_links do |t|
      t.text :url
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
