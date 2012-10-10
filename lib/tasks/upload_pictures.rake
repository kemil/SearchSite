namespace :boat do
  desc "Upload all boat pictures to S3"
  task :pictures_upload => :environment do
    boats = Boat.find(:all)
    puts "---------------All boats Collected-------------"
    boats.each do |boat|
      boat.pictures.each do |pic|
        io = open(URI.parse(pic.url))
        def io.original_filename; puts base_uri;File.basename(base_uri.to_s, File.extname(base_uri.to_s)); end
        pic.image = io
        pic.save
      end
    end
    puts "--------All boat pictures are uploaded---------"
  end
end
