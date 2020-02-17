schedule_file = 'config/schedule.yml'

if File.exist?('config/schedule.yml') && !Rails.env.test?
  Sidekiq::Cron::Job.load_from_hash!(YAML.load_file(schedule_file))
end
