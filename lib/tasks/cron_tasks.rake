namespace :cron_tasks do
  desc "Pull all the top stories from Hacker News API"
  task pull_top_stories_from_hacker_news: :environment do
  	begin
	  	client = HackernewsRuby::Client.new
	  	top_stories = client.top_stories.sort! {|x, y| y <=> x}[0..15]
	    top_stories.each do |story_id|
	    	story = client.get_item(story_id)
	    	Post.create(title: story.title, url: story.url, score: story.score, hacker_news_id: story_id, hn_timestamp: DateTime.strptime("#{story.time}",'%s'))
	    end
	  rescue

    end
  end

end
