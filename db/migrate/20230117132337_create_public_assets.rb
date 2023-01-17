class CreatePublicAssets < ActiveRecord::Migration[7.0]
  def change
    create_table :public_assets do |t|
      t.string :url
      t.string :validate_by

      t.timestamps
    end
  end
end
