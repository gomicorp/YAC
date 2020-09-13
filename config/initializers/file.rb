require 'open-uri'
require 'tempfile'

class File
  # File.download_from_url
  #
  # @param :url
  # @return <Tempfile>
  def self.download_from_url(url)
    stream = URI.open(url, 'rb')
    return stream if stream.respond_to?(:path) # Already file-like

    tempfile = Tempfile.new.tap do |file|
      file.binmode
      IO.copy_stream(stream, file)
      stream.close
      file.rewind
    end

    self.open(tempfile)
  end
end
