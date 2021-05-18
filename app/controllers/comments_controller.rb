class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @comment = current_user.comments.build(params.require(:comment).permit(:content, :user_id, :micropost_id))
    if @comment.save
      flash[:success] = "Comment posted!"
      redirect_to @comment.micropost
    else
      @micropost = Micropost.find(params[:comment][:micropost_id])
      @comments = @micropost.comments.paginate(page: params[:page])
      render 'microposts/show'
    end
  end
end
