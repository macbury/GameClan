task :reprocess_photos => :environment do
  Photo.all.each { |photo| photo.image.reprocess! }
end
