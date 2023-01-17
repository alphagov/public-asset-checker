class CreatePublicAssetStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :public_asset_statuses do |t|
      t.integer :public_asset_id
      t.integer :size
      t.string :version

      t.timestamps
    end
  end
end
