class StoriesController < ApplicationController
	#load_and_authorize_resource :except => [:mark_post_as_read]
  before_action :authenticate_user!
  
  # Method: To display dashboard data
  def index
  	@stories = Story.all.collect(&:id)
    # Fetch stories deleted by user to remove them from data to be displayed
    @deleted_stories = Story.where(id: current_user.read_and_deleteds.deleted.collect(&:story_id)).collect(&:id)
    @stories_to_display = Story.where(id: (@stories - @deleted_stories)).order("hn_timestamp DESC").paginate(:page => params[:page], :per_page => 30)
  end

  # Method: To soft delete a story for user 
  def delete_story_for_user
  	@story_id = params[:story_id]  
    if ReadAndDeleted.create(user_id: current_user.id, story_id: @story_id, action_type: "deleted")
      flash[:notice] = "Story deleted successfully"
    else
      flash[:alert]  = "Not able to delete Story"
    end
    redirect_to root_path
  end
  
  #Method: To mark a story as read item.
  def mark_post_as_read
  	@story_id = params[:story_id]
    if ReadAndDeleted.create(user_id: current_user.id, story_id: @story_id, action_type: "read")
      flash[:notice] = "Marked as read successfully"
    else
      flash[:alert]  = "Not able to mark story as read item"
    end
  	redirect_to root_path
  end

private
  def story_params
    params.require(:story).permit(:title, :url, :score, :hacker_news_id, :hn_timestamp, :descendants)
  end
end