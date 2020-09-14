# JSRequest
#
# Make Link : Javascript formatted Asynchronous Request
module LinkToHelper
  module JsRequestHelper
    def js_link_to(name = nil, options = nil, html_options = nil, &block)
      html_options = add_remote_and_script_data(html_options)
      link_to(name, options, html_options, &block)
    end

    private

    def js_request_catcher(path = nil)
      path.to_s.scan(/\.js/).first ? add_remote_and_script_data : {}
    end

    # Automatic Add arguments to make script link
    # => { remote: true, data: { type: 'script' } }
    def add_remote_and_script_data(html_options = nil)
      html_options ||= {}
      html_options[:remote] = true
      html_options[:data] ||= {}
      html_options[:data][:type] = 'script'

      html_options
    end
  end
end
