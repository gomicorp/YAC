class HelperComponent
  def initialize(view)
    @view = view
  end

  def render(options = {}, locals = {}, &block)
    @view.render(options, locals, &block)
  end

  module Factory
    def self.declare_component_interface_of(component_classname)
      Object.const_get(component_classname).new(self)
    end
  end
end
