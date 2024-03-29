Rails.application.routes.draw do
  resources :public_assets
  post "/public_asset_statuses", to: "public_asset_statuses#create"
  get "/rake_runner", to: "public_assets#rake_runner"
  get "/healthcheck/live", to: proc { [200, {}, %w[OK]] }
  get "/healthcheck/ready", to: GovukHealthcheck.rack_response

  root "public_assets#index"
end
