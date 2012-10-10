class Picture < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true

  validates :url, :uniqueness => {:scope => [:imageable_type, :imageable_id]}, :presence => true
  
  Paperclip.interpolates :boat_permalink do |attachment, style|
    attachment.instance.imageable.permalink
  end
  
  Paperclip.interpolates :img_type do |attachment, style|
    File.extname(attachment.instance.url)
  end
  
  has_attached_file :image,
                     :styles => {
                       :normal => ["650x364#"],
                       :thumb => ["230x150#"],
                       :mini => ["125x83#"]
                     },
                     :default_style => :normal,
                     :default_url => nil,
                     :storage => :s3,
                     :boat_permalink => self,
                     :bucket => AMAZON_S3_BUCKET,
                     :path => "yachtimages/:id_partition/:boat_permalink:filename.:style:img_type",
                     :s3_credentials => {
                       :access_key_id => AMAZON_ACCESS_KEY_ID,
                       :secret_access_key => AMAZON_SECRET_ACCESS_KEY
                     }
end
