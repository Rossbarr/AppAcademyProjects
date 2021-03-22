class AlbumsController < ApplicationController
  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to album_url(@album)
    else
      @bands = Band.all
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def new
    @album = Album.new(band_id: params[:band_id])
    @bands = Band.all
    render :new
  end

  def edit
    @album = Album.find_by(id: params[:id])
    @bands = Band.all

    if @album
      render :edit
    else
      redirect_to bands_url
    end
  end

  def show
    @album = Album.find_by(id: params[:id])

    if @album
      render :show
    else
      redirect_to bands_url
    end
  end

  def update
    @album = Album.find_by(id: params[:id])
    
    if @album.update_attributes(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    @album = Album.find_by(id: params[:id])

    if @album.destroy
      redirect_to band_url(params[@album.band])
    else
      flash[:errors] = @album.errors.full_messages
      redirect_to album_url(@album)
    end
  end

  private

  def album_params
    params.require(:album).permit(:name, :how_recorded, :year, :band_id)
  end
end
