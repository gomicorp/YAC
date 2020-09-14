module LinkToHelper
  module HistoryBackwardHelper
    # Request trigger
    # referer url
    # by hacking case..when clause inside of 'url_for' method
    # ('url_for' method is also inside of 'link_to' method)
    def back_to(name = nil, html_options = nil, &block)
      link_to(name, :back, html_options, &block)
    end
  end
end
