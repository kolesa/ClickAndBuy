task :user_update => :environment do
  User.update_likes
end 
