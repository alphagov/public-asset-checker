class PublicAssetStatusesController < ApplicationController
  def create
    @public_asset_status = PublicAssetStatus.new(public_asset_status_params)

    if @public_asset_status.save
      redirect_to public_asset_url(@public_asset_status.public_asset), notice: "Public asset status was successfully created."
    else
      redirect_to public_asset_url(@public_asset_status.public_asset), notice: "Record not created - invalid value."
    end
  end

private

  def public_asset_status_params
    params.require(:public_asset_status).permit(:public_asset_id, :size, :version)
  end
end
