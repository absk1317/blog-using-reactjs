class CommentsController < ApplicationController
  respond_to :json

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment
    else
      render json: comment.errors, status: :unprocessable_entity
    end

  end

  def update
    comment = Comment.find(params[:id])
    if comment.update(comment_params)
      render json: comment
    else
      render json: blog.errors, status: :unprocessable_entity
    end
  end

  def delete
    comment = Comment.find(params[:id])
    respond_with comment.destroy
    head :no_content
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :blog_id)
  end
end
