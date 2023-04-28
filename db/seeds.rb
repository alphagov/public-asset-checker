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
    },
  ],
)

if Rails.env.development?
  require "faker"

  to_date_time = Time.zone.today
  from_date_time = to_date_time - 30

  public_assets_by_size = PublicAsset.where(validate_by: "size")
  public_assets_by_version = PublicAsset.where(validate_by: "version")

  (from_date_time..to_date_time).each do |date_time|
    public_assets_by_size.all.each do |asset|
      PublicAssetStatus.create!(
        public_asset_id: asset.id,
        size: Faker::Number.number(digits: 6),
        created_at: date_time,
        updated_at: date_time,
      )
    end

    public_assets_by_version.all.each do |asset|
      PublicAssetStatus.create!(
        public_asset_id: asset.id,
        version: "T=\"#{Faker::Number.number(digits: 3)}\"",
        created_at: date_time,
        updated_at: date_time,
      )
    end
  end
end
