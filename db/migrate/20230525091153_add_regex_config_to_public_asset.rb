class AddRegexConfigToPublicAsset < ActiveRecord::Migration[7.0]
  def change
    change_table :public_assets do |t|
      t.string :hosted_version_regex, :source_version_regex
    end
  end
end
