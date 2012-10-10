require 'yaml'
namespace :locale do
  desc "Copy translations from DB to YML. Overwrites."
  task :db_to_yml, [:environment, :type, :locale] => :environment do |t, args|
    if args[:type] == 'yml'
      File.open("#{Rails.root}/config/locales/#{args[:locale]}.yml", "w") unless File.exist?("#{Rails.root}/config/locales/#{args[:locale]}.yml")
      info = YAML::load(IO.read("#{Rails.root}/config/locales/#{args[:locale]}.yml"))
      key_yaml = []
      opts = info["#{args[:locale]}"]
      if info
        info["#{args[:locale]}"].each do |key, value|
          key_yaml = [key]
        end
      end

      Translation.where(:locale => args[:locale]).each do |trans|
        opts = opts.merge(trans.key => trans.value) if key_yaml.present? && !key_yaml.include?(trans.key)
      end

      File.open("#{Rails.root}/config/locales/#{args[:locale]}.yml", 'w') { |f| YAML.dump({args[:locale] => opts}, f) }
      puts "#{args[:locale]} locale import done!"
    else
      puts 'File type was wrong'
    end
  end
end