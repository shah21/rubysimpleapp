class PostsController < ApplicationController
    before_action :require_user_is_logged_in, only: [:create, :update, :destroy]
    before_action :check_authorization, only: [:destroy, :update]

    def index
        @user = User.find(Current.user.id)
        @posts = @user.posts
    end

    def new
        @post = Post.new
    end
    
    def create
        @post = Post.new(post_params)
        @post.user_id = Current.user.id
        if @post.save
            redirect_to posts_path,notice:'Post created successfully 😊'
        else
            puts @post.errors.full_messages
            flash.now[:alert] = 'Post not created'
            render 'new'
        end
    end

    def show
        @post = Post.find(params[:id])
        @current_user = Current.user
    end

    def edit
        @post = Post.find(params[:id])
    end
    
    def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
          redirect_to @post,notice:"Post was successfully updated"
        else
          flash.now[:alert] = "Something went wrong"
          render 'edit'
        end
    end

    def destroy
        @post = Post.find(params[:id])
        if @post
            @post.destroy
            redirect_to posts_path, notice: "Post was successfully deleted"
        else
            redirect_to posts_path, alert: "Post not found"
        end
    end
    
    
    def post_params
        params.require(:post).permit(:title, :details,:final_date)
    end

    def check_authorization
        if !Current.user.id == Post.find(params[:id]).user.id?
            redirect_to root_path, notice: "You don't have permission to do that"
        end
    end
end