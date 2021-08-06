class CommentsController < ApplicationController
    def create
        @comment = Comment.new(comment_params)
        @comment.user = Current.user
        @comment.post_id = params[:post_id]
        if @comment.save
            redirect_to @comment.post,notice: "Comment added"
        else
            flash.now[:alert] = "Error adding comment"
            render @comment.post
        end
    end


    def comment_params
        params.require(:comment).permit(:body)
    end
end