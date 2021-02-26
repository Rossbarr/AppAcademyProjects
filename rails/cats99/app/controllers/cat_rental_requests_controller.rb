class CatRentalRequestsController < ApplicationController
  def new
    @cat = Cat.find_by(id: params[:cat_id])
    render(:new)
  end

  def create
    @cat_rental_request = CatRentalRequests.new(cat_rental_request_params)
    @cat_rental_request.cat_id = params[:cat_id]

    if @cat_rental_request.save
      redirect_to(cat_url(params[:cat_id]))
    else
      @cat = Cat.find_by(id: params[:cat_id])
      render(:new)
    end
  end

  private

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:start_date, :end_date, :status)
  end
end
