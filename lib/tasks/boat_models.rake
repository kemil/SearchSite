
namespace :load do
  desc "Load boat models from json file to db"
  task :boat_models => :environment do |t, args|
    pj = ActiveSupport::JSON.decode(IO.read("#{Rails.root}/db/boat_models.json"))
    
    pj.each do |k, v|
      model = k
      description = v['0']['description']
      description = description.gsub(/[\r\n]/, ' ').gsub(/\s{2,}/, ' ')

      bm = BoatModel.where(:name => model)
      unless bm.present?
        j = BoatModel.create!(:name => model, :description => description)
        BoatModelMatch.create(:matcher => model.downcase, :boat_model_id => j.id)
      end
    end

  end
end
