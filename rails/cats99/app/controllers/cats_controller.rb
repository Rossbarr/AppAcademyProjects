class CatsController < ApplicationController
  def index
    @cats = Cat.all()

    render(:index)
  end

  def create
    @cat = Cat.new(cat_params)

    if @cat.save
      redirect_to(cat_url(@cat))
    else
      render(:new)
    end
  end

  def new
    @cat = Cat.new
    render(:new)
  end

  def edit
    @cat = Cat.find_by(id: params[:id])
    render(:edit)
  end

  def show
    @cat = Cat.find_by(id: params[:id])

    if @cat
      render(:show)
    else
      redirect_to(cats_url)
    end
  end

  def update
    @cat = Cat.find_by(id: params[:id])

    if @cat.update_attributes(cat_params)
      redirect_to(cat_url(@cat))
    else
      render(:edit)
    end
  end

  def destroy
    @cat = Cat.find_by(id: params[:id])

    if @cat.destroy
      redirect_to(cats_url)
    else
      render(cat_url(@cat))
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :sex, :birth_date, :color, :description)
  end
end
