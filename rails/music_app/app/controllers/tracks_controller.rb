class TracksController < ApplicationController
  def create
    @track = Track.new(tracks_params)

    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def new
    @track = Track.new(album_id: params[:album_id])
    @albums = Album.find_by(id: params[:album_id]).sibling_albums
    render :new
  end

  def edit
    @track = Track.find_by(id: params[:id])
    @albums = Album.all
    render :edit
  end

  def show
    @track = Track.find_by(id: params[:id])
    render :show
  end

  def update
    @track = Track.find_by(id: params[:id])

    if @track.update_attributes(tracks_params)
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    @track = Track.find_by(id: params[:id])

    if @track.update_attributes(tracks_params)
      redirect_to album_url(@track.album)
    else
      flash.now[:errors] = @track.errors.full_messages
      redirect_to track_url(@track)
    end
  end

  private

  def tracks_params
    params.require(:track).permit(:title, :album_id, :ord, :is_regular, :lyrics)
  end
end
