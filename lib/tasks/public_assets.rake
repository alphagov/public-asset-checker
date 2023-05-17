namespace :public_assets do
  desc "Checks the current size of all known public assets."
  task check_all_sizes: :environment do
    notifier = Notifier.new
    PublicAsset.sizes.all.find_each do |asset|
      checker = AssetSizeChecker.new(asset)
      notification = checker.compare
      notifier.notify(notification)
    end
  end

  desc "Checks the current version of all known public assets."
  task check_all_versions: :environment do
    notifier = Notifier.new
    PublicAsset.versions.all.find_each do |asset|
      checker = AssetVersionChecker.new(asset)
      notification = checker.compare
      notifier.notify(notification)
    end
  end
end
