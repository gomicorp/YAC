module Service
  module NavBarHelper
    def nav_item_link_to(*args, &block)
      name = block_given? ? capture(block) : args.shift
      options = args.shift || {}
      html_options = args.shift || {}

      html_options[:class] ||= ''
      html_options[:class] += ' nav-link text-capitalize'
      html_options[:class].strip!

      render(
        'layouts/service/components/nav-bar/item/active_link_to',
        name: name,
        options: options,
        html_options: html_options
      )
    end

    def nav_dropdown_item(type = :link_to, name = nil, options = nil, html_options = nil, &block)
      html_options, options, name = options, name, block if block_given?
      options ||= {}
      html_options ||= {}

      icon_class = html_options.delete(:icon)
      icon = icon_class ? content_tag(:span, content_tag(:i, nil, class: icon_class), class: 'position-relative mr-2', style: 'top: 1px') : ''

      name = content_tag(:span, name)

      html_options[:class] ||= ''

      content_tag(:li) do
        case type
        when :link_to
          html_options[:class] += ' dropdown-item'
          html_options[:class].strip!
          link_to((icon + name).html_safe, options, html_options)
        when :active_link_to
          html_options[:class] += ' dropdown-item'
          html_options[:class].strip!
          active_link_to((icon + name).html_safe, options, html_options)
        when :hr
          html_options[:class] += ' dropdown-divider'
          html_options[:class].strip!
          content_tag(:hr, nil, html_options)
        end
      end
    end
  end
end
