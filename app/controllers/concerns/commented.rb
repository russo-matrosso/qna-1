module Commented

  extend ActiveSupport::Concern

  included do
    after_action :publish_comment, only: [:make_comment]
  end

  def make_comment
  	@comment = set_commentable.comments.create(comment_params.merge(user: current_user))
  end


  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def model_klass
    controller_name.classify.constantize
  end

  def set_commentable
    model_klass.find(params[:id])
  end

 def publish_comment
  if @comment.errors.any?
    return
  end
  id = @comment.commentable_type == "Answer" ? @comment.commentable.question.id : @comment.commentable.id

  ActionCable.server.broadcast("comments/#{id}", {
      partial: ApplicationController.render(partial: 'comments/comment',
                                            locals: { comment: @comment }),
      comment: @comment})
  end
end