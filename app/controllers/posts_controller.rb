class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @posts = Post.limit(10).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      flash[:notice] = '投稿しました' # 成功時のフラッシュメッセージ
      redirect_to posts_path # 一時的にトップページへリダイレクト
    else
      flash[:alert] = '投稿に失敗しました' # 失敗時のフラッシュメッセージ
      render :new # 投稿描画を再表示
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def destroy
    post = Post.find_by(id: params[:id])
    
    if post.user == current_user
      post.destroy
      flash[:notice] = '投稿が削除されました'
    end
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content) # title と content のみ許可する
  end
end
