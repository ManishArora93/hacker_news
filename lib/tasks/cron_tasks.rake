namespace :cron_tasks do
  desc "Pull all the top stories from Hacker News API"
  task pull_top_stories_from_hacker_news: :environment do
  	User.create(email: "manisharora@gmail.com")
  end

end
