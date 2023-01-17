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

  to_date = Time.zone.today
  from_date = to_date - 30

  public_assets_by_size = PublicAsset.where(validate_by: "size")
  public_assets_by_version = PublicAsset.where(validate_by: "version")

  (from_date..to_date).each do
    public_assets_by_size.all.each do |asset|
      PublicAssetStatus.create!(
        public_asset_id: asset.id,
        size: Faker::Number.number(digits: 6),
      )
    end

    public_assets_by_version.all.each do |asset|
      PublicAssetStatus.create!(
        public_asset_id: asset.id,
        version: "v=#{Faker::Number.number(digits: 3)}",
      )
    end
  end
end
