class CatsController < ApplicationController
  before_action :require_user, only: [:new, :create, :edit, :update]

  def index
    @cats = Cat.all()

    render(:index)
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.owner = current_user

    if @cat.save
      redirect_to(cat_url(@cat))
    else
      flash.now[:errors] = @cat.errors.full_messages
      render(:new)
    end
  end

  def new
    @cat = Cat.new
    render(:new)
  end

  def edit
    @cat = current_user.cats.find(params[:id])
    render(:edit)
  end

  def show
    @cat = Cat
      .where(id: params[:id])
      .includes(:requests, :owner)
      .first

    if @cat
      render(:show)
    else
      redirect_to(cats_url)
    end
  end

  def update
    @cat = current_user.cats.find(params[:id])

    if @cat.update_attributes(cat_params)
      redirect_to(cat_url(@cat))
    else
      flash.now[:errors] = @cat.errors.full_messages
      render(:edit)
    end
  end

  def destroy
    @cat = Cat.find_by(id: params[:id])

    if @cat.destroy
      redirect_to(cats_url)
    else
      flash.now[:errors] = ["YOU CAN'T DO THAT"]
      render(cat_url(@cat))
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :sex, :birth_date, :color, :description)
  end
end
