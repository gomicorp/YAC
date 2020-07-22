# frozen_string_literal: true

# === URI
# URI vs URL : https://lambdaexp.tistory.com/39
#
module URI
  def origin
    "#{scheme}://#{host}"
  end

  def url
    origin + path
  end

  def parameters
    ::URI.decode_www_form(query).to_h.symbolize_keys
  end
  alias params parameters

  class Type < ActiveRecord::Type::Value
    def cast(value)
      URI(value)
    rescue ArgumentError
      value
    end

    def serialize(value)
      value.to_s
    end
  end
end
