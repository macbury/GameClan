task :reprocess_photos => :environment do
  Photo.all.each { |photo| photo.image.reprocess! }
end

task :reprocess_logos => :environment do
  Guild.all.each { |guild| guild.logo.reprocess! }
end
