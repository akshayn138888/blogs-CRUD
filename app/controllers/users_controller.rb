class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :new,:create] 
  before_action :correct_user, only: [:edit, :update ]
  
     def new
        if user_signed_in?
          redirect_to posts_path
        else 
        @user = User.new
        end
     end
    
      def create
        @user = User.new params.require(:user).permit(:name, :email, :password, :password_confirmation)
        if @user.save
          flash.delete(:warning)
          redirect_to new_session_path
        else
          flash[:warning] = "unable to create user"
          render :new
        end
      end
      
      def edit
        @user = User.find(params[:id])
      end
      
      def update
        @user = User.find current_user.id
        @user_info= params.require(:user).permit(:name,:email,:old_password, :password ,:password_confirmation)
        if ((@user&.authenticate(@user_info[:old_password])) && (@user_info[:password]!=@user_info[:old_password]))
          if @user.update_attribute(:password, @user_info[:password])
            redirect_to  posts_path
          else
            flash[:warning] = "Couldn't Update"
            redirect_to edit_user_path(@user)
        end
      end
      
      end
      private
      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user == @user
      end
      
 end 
      
      # def edit
      #   id = params[:id]
      #   @post = Post.find(id)
      # end 
      
      # def update
      #   id = params[:id]
      #   @post = Post.find(id)
      #   if @post.update(params.require(:post).permit(:title, :body))
      #      redirect_to post_path(@post)
      #   else
      #      render :edit
      #   end
      # end


