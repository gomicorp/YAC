require_relative './uri'

ActiveRecord::Type.register(:uri, URI::Type)
