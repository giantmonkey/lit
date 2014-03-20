module Lit
  module ApplicationHelper
    def method_missing method, *args, &block
      if method.to_s.end_with?('_path') or method.to_s.end_with?('_url')
        if main_app.respond_to?(method)
          main_app.send(method, *args)
        else
          super
        end
      else
        super
      end
    end

    def respond_to?(method)
      if method.to_s.end_with?('_path') or method.to_s.end_with?('_url')
        if main_app.respond_to?(method)
          true
        else
          super
        end
      else
        super
      end
    end

    def draw_icon(icon, opts={})
      raw("<i class=\"fa fa-#{icon} icon-#{icon} #{opts[:class]}\" title=\"#{opts[:title]}\" ></i>")
    end

    def ejs(val)
      escape_javascript val.to_s
    end

    def allow_wysiwyg_editor?(key)
      Lit.all_translations_are_html_safe || key.to_s =~ /(\b|_|\.)html$/
    end

    def parent_layout(layout)
      @view_flow.set(:layout, output_buffer)
      output = render(:file => "layouts/#{layout}")
      self.output_buffer = ActionView::OutputBuffer.new(output)
    end

  end
end
