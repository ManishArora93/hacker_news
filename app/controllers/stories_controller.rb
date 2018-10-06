class StoriesController < ApplicationController
	#load_and_authorize_resource :except => [:mark_post_as_read]
  #before_action :authenticate_user!

  def index
  	@stories = Story.all.collect(&:id)
    @deleted_stories = Story.where(id: current_user.read_and_deleteds.deleted.collect(&:story_id)).collect(&:id)
    @stories_to_display = Story.where(id: (@stories - @deleted_stories)).order("hn_timestamp DESC").paginate(:page => params[:page], :per_page => 30)
    #.sort_by {|a| a.hn_timestamp}.reverse
  end

  def delete_story_for_user
  	@story_id = params[:story_id]  
    ReadAndDeleted.create(user_id: current_user.id, story_id: @story_id, action_type: "deleted")
    flash[:notice] = "Post deleted successfully"
    redirect_to root_path
  end

  def mark_post_as_read
  	@story_id = params[:story_id]
    ReadAndDeleted.create(user_id: current_user.id, story_id: @story_id, action_type: "read")
    flash[:notice] = "Marked as read successfully"
  	redirect_to root_path
  end

private
  def story_params
    params.require(:story).permit(:title, :url, :score, :hacker_news_id, :hn_timestamp, :descendants)
  end
end