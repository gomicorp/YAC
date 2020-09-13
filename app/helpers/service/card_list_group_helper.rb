module Service
  module CardListGroupHelper
    def card_list_group_item(*args, &block)
      name = block_given? ? capture(block) : args.shift
      options = args.shift || {}
      html_options = args.shift || {}

      html_options[:class] ||= ''
      html_options[:class] += ' list-group-item list-group-item-action d-flex align-items-center text-capitalize'
      html_options[:class] += ' disabled' if html_options.delete(:disabled)
      html_options[:class].strip!

      badge = html_options.delete(:badge) || ''
      if badge.present?
        badge = content_tag(:span, badge, class: 'badge bg-secondary ml-2')
      end

      icon = content_tag(:i, nil, class: 'far fa-angle-right ml-auto')
      active_link_to((name + badge + icon).html_safe, options, html_options.merge(active: :exclusive))
    end
  end
end
