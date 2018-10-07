namespace :cron_tasks do
  desc "Pull all the top stories from Hacker News API"
  task pull_top_stories_from_hacker_news: :environment do
  	client = HackernewsRuby::Client.new
  	top_stories = client.top_stories.sort! {|x, y| y <=> x}[0..89]
  	failed_story_ids = {}     
    top_stories.each do |story_id|
    	begin
	    	story = Story.where(hacker_news_id: story_id).first
	    	if story.present?
	  			updated_story = client.get_item(story_id)
	        story.score = updated_story.score
	        story.descendants = updated_story.descendants
	        story.save!
	    	else
		    	story = client.get_item(story_id)
		    	new_story = Story.new
		    	new_story.title = story.title
		    	new_story.url = story.url
		    	new_story.score = story.score
		    	new_story.hacker_news_id = story_id
		    	new_story.hn_timestamp = story.time
		    	new_story.descendants = story.descendants
		    	new_story.save!
		    end
		  rescue Exception => e
	      failed_story_ids[story_id] << e.message
      end
	  end
  end
end