middleware_dir_path = Rails.root.join('app', 'middleware')
middleware_file_locations = Dir[middleware_dir_path.join('**/*.rb')]

def get_class_name_from_file_name(dir_path, file_path)
  bold_filename = file_path.gsub(dir_path.to_s, '').gsub('.rb', '').camelcase
  bold_filename.constantize
end

middleware_file_locations.each do |middleware_file_location|
  require(middleware_file_location)
  class_name = get_class_name_from_file_name(middleware_dir_path, middleware_file_location)
  Rails.application.config.middleware.insert_after Rails::Rack::Logger, class_name
end
