class UpdateVersionAndSizeOnPublicAssetStatuses < ActiveRecord::Migration[7.0]
  def change
    change_table :public_asset_statuses do |t|
      t.remove :version, type: :string
      t.rename :size, :value
    end
  end
end
