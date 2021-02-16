class CommentsController < ApplicationController
  def index
    if comment_params[:commenter_id]
      thing = User.find(comment_params[:commenter_id])
    elsif comment_params[:artwork_id]
      thing = Artwork.find(comment_params[:artwork_id])
    end
    render(json: thing.comments)
  end
  
  def create
    comment = Comment.new(comment_params)
    if comment.save()
      render(json: comment)
    else
      render(json: comment.errors.full_messages, status: :unprocessable_entity)
    end
  end

  def destroy
    comment = Comment.find(params["id"])
    if comment.destroy
      render(json: comment)
    else
      render(json: comment.errors.full_messages, status: :unprocessable_entity)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:artwork_id, :commenter_id, :body)
  end
end
