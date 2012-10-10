require 'yaml'
namespace :locale do
  desc "Copy translations from yml yo db. Non-overwriting."
  task :yml_to_db, [:environment, :type, :locale] => :environment do |t, args|
    if args[:type] == 'yml' || args[:type] == 'sql'
      if args[:type] == 'sql'
        info = YAML::load(IO.read("#{Rails.root}/config/database.yml"))
        env =  args[:environment]
        unless info[env].nil?
          `psql -U #{info[env]['username']} -d #{info[env]['database']} -f translation_table.sql`
          puts 'English locale import done!'
        else
          puts 'The environment not found!'
        end
      elsif args[:type] == 'yml'
        info = YAML::load(IO.read("#{Rails.root}/config/locales/#{args[:locale]}.yml"))
        info["#{args[:locale]}"].each do |key, value|
          translation = Translation.where(:key => key)
          Translation.create!(:key => key, :value => value, :locale => args[:locale]) if translation.blank?
        end
        puts "#{args[:locale]} locale import done!"
      end
    else
      puts 'File type was wrong'
    end
  end
end