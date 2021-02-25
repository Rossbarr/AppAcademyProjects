class CatsController < ApplicationController
  def index
    @cats = Cat.all()

    render(:index)
  end

  def show
    @cat = Cat.find_by(id: params[:id])

    if @cat
      render(:show)
    else
      redirect_to(cats_url)
    end
  end

  def new
    render(:new)
  end

  def create
    render(json: params)
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :sex, :birth_date, :color, :description)
  end
end
