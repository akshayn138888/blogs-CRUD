class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show] 
  before_action :authorize!, only: [:edit, :update, :destroy]

  def index
        @posts = Post.all.order('updated_at DESC')
      end
    
      def new
        @post = Post.new # we need an instance of our resource to be used with `form_with`
      end
      
      def create
        @post = Post.new(params.require(:post).permit(:title, :body))
        @post.user = current_user
        if @post.save
            redirect_to posts_path
          else
            render :new
          end
      end 
      def show
        id = params[:id]
        @post = Post.find(id)
        @comment = Comment.new 
    # For the list of answer
    @comments = @post.comments.order(created_at: :desc)
      end
      
      def edit
        id = params[:id]
        @post = Post.find(id)
      end 
      
      def update
        id = params[:id]
        @post = Post.find(id)
        if @post.update(params.require(:post).permit(:title, :body))
           redirect_to post_path(@post)
        else
           render :edit
        end
      end

      
      def destroy
        id = params[:id]
        @post = Post.find(id)
        @post.destroy
        redirect_to posts_path
      end
      private
      def authorize! 
        redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, Post)
      end
    
end
