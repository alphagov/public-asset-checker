Rails.application.routes.draw do
  resources :public_assets
  get "/healthcheck/live", to: proc { [200, {}, %w[OK]] }
  get "/healthcheck/ready", to: GovukHealthcheck.rack_response

  root "public_assets#index"
end
