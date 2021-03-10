class RentalRequestsController < ApplicationController
  before_action :require_user

  def new
    @cat = Cat.find_by(id: params[:cat_id])
    render(:new)
  end

  def create
    @rental_request = RentalRequest.new(rental_request_params)
    @rental_request.cat_id = params[:cat_id]
    @rental_request.user_id = current_user.id

    if @rental_request.save
      redirect_to(cat_url(params[:cat_id]))
    else
      @cat = Cat.find_by(id: params[:cat_id])
      flash.now[:errors] = @rental_request.errors.full_messages
      render(:new)
    end
  end

  def update
    @rental_request = current_user.received_requests.find(params[:rental_request][:id])

    if params[:rental_request][:status] == "APPROVED"
      @rental_request.approve!
    elsif params[:rental_request][:status] == "DENIED"
      @rental_request.deny!
    end

    redirect_to(cat_url(params[:cat_id]))
  end

  private

  def rental_request_params
    params.require(:rental_request).permit(:start_date, :end_date, :status)
  end
end
