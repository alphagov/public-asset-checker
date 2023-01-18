namespace :public_assets do
  desc "Checks the current size of all known public assets."
  task :check_all_sizes => :environment do
    checker = AssetSizeChecker.new
    checker.compare_sizes
  end
end
