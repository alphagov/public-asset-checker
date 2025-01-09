PublicAsset.create!(
  [
    {
      url: "https://www.googletagmanager.com/gtm.js?id=GTM-MG7HG5W",
      validate_by: "size",
    },
    {
      url: "https://www.googletagmanager.com/gtag/js?id=G-S5RQ7FTGVR&l=dataLayer&cx=c",
      validate_by: "size",
    },
    {
      url: "https://cdn.speedcurve.com/js/lux.js?id=47044334",
      validate_by: "version",
      hosted_version_regex: 'H="(\d+)"',
      source_version_regex: 'SCRIPT_VERSION = "(\d+)"',
    },
  ],
)

if Rails.env.development?
  require "faker"

  to_date_time = Time.zone.today
  from_date_time = to_date_time - 30

  (from_date_time..to_date_time).each do |date_time|
    PublicAsset.find_each do |asset|
      PublicAssetStatus.create!(
        public_asset_id: asset.id,
        value: Faker::Number.number(digits: 4),
        created_at: date_time,
        updated_at: date_time,
      )
    end
  end
end
