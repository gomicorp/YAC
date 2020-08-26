module Embed
  module ActiveStorage
    class DirectUploadsController < ::ActiveStorage::DirectUploadsController
      skip_forgery_protection
    end
  end
end
