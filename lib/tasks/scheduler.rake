desc "This task is called by the Heroku scheduler add-on"
task :clear_songs => :environment do
  puts "Clearing DB"
  Song.delete_unused
  puts "done."
end
desc "This task clears artists and stuff"
task :clear_artists => :environment do
  puts "Clearning DB"
  Artist.delete_unused
  puts "done."
end
