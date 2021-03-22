class NotesController < ApplicationController
  before_action :require_user!

  def create
    @note = Note.new(notes_params)
    @note.user_id = current_user.id
    @note.track_id = params[:note][:track_id]
    @track = Track.find_by(id: params[:note][:track_id])

    if @note.save
      redirect_to track_url(@track)
    else
      flash[:errors] = @note.errors.full_messages
      redirect_to track_url(@track)
    end
  end

  def update
    @note = Note.find_by(user_id: current_user.id, track_id: params[:note][:track_id])
    @track = Track.find_by(id: params[:note][:track_id])

    if @note.update_attributes(notes_params)
      redirect_to track_url(@track)
    else
      flash[:errors] = @note.errors.full_messages
      redirect_to track_url(@track)
    end
  end

  def destroy
    @note = Note.find_by(user_id: current_user.id, track_id: params[:note][:track_id])
    @track = Track.find_by(id: params[:note][:track_id])

    if @note.destroy
      redirect_to track_url(@track)
    else
      flash[:errors] = @note.errors.full_messages
      redirect_to track_url(@track)
    end
  end

  private

  def notes_params
    params.require(:note).permit(:note)
  end
end
