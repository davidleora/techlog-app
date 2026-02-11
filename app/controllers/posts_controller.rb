class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      flash[:notice] = '投稿しました' # 成功時のフラッシュメッセージ
      redirect_to root_path # 一時的にトップページへリダイレクト
    else
      flash[:alert] = '投稿に失敗しました' # 失敗時のフラッシュメッセージ
      render :new # 投稿描画を再表示
    end
  end

  def show
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :content) # title と content のみ許可する
  end
end
