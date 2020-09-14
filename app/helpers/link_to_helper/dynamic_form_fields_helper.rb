module LinkToHelper
  module DynamicFormFieldsHelper
    def link_to_add_fields(name, form, association = nil, html_options = nil, &block)
      name, form, association, html_options = args_for_first_to_block(name, form, association, html_options, &block) if block_given?

      new_object = form.object.send(association).klass.new
      id = new_object.object_id
      fields = fields_markup(form, association, new_object, id, "#{association.to_s.singularize}_fields")

      final_add_field_link name, fields, id, html_options || {}, default_class: 'add_fields'
    end

    def link_to_add_condition(name, form, type = nil, html_options = nil, &block)
      name, form, type, html_options = args_for_first_to_block(name, form, type, html_options, &block) if block_given?

      new_object = form.object.send("build_#{type}")
      id = "new_#{type}"
      fields = fields_markup(form, "#{type}_fields", new_object, id, "#{type}_fields")

      final_add_field_link name, fields, id, html_options || {}, default_class: 'add_condition_fields'
    end


    private

    def args_for_first_to_block(*args, &block)
      [capture(&block), *args]
    end

    def final_add_field_link(name, fields, id, html_options, default_class: nil)
      link_to(
        name, '#',
        html_options.reverse_deep_merge(
          class: default_class,
          data: {
            id: id,
            fields: fields.gsub("\n", '')
          }
        )
      )
    end

    def fields_markup(form, method, new_object, id, template)
      form.send(method, new_object, child_index: id) { |f| render(template, form: f) }
    end
  end
end
