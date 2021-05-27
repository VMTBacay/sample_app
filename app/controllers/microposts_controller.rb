class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @microposts = Micropost.where(Micropost.arel_table[:content].matches("%#{params[:search_term]}%")).paginate(page: params[:page])
  end

  def show
    @micropost = Micropost.where(id: params[:id]).first
    if @micropost
      @comment = @micropost.children.build
      @comments = @micropost.children.where(relationship_type: 1).paginate(page: params[:page])
    else
      redirect_to root_url
    end
  end

  def quote
    @parent = Micropost.find(params[:id])
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      if @micropost.relationship_type == 1
        flash[:success] = "Comment created!"
        redirect_to @micropost.parent
      else
        flash[:success] = "Micropost created!"
        redirect_to root_url
      end
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def edit
    @micropost = Micropost.find(params[:id])
  end

  def update
    @micropost = Micropost.find(params[:id])
    @micropost.image.attach(params[:micropost][:image]) unless params[:micropost][:image].nil?
    if @micropost.update(micropost_params)
      flash[:success] = "Micropost updated"
      redirect_to @micropost
    else
      render 'edit'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :image, :parent_id, :relationship_type)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
