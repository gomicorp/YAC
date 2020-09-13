module Service
  module ButtonHelper
    def button_xs(text, path = nil, html_options = nil)
      html_options ||= {}
      html_options[:btn_class] ||= html_options.delete(:class)

      render(
        'layouts/service/components/button/xs',
        path: path,
        text: text,
        **html_options
      )
    end
  end
end
