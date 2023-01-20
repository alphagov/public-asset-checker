namespace :public_assets do
  desc "Checks the current size of all known public assets."
  task check_all_sizes: :environment do
    checker = AssetSizeChecker.new
    checker.compare
  end

  desc "Checks the current version of all known public assets."
  task check_all_versions: :environment do
    checker = AssetVersionChecker.new
    checker.compare
  end
end
