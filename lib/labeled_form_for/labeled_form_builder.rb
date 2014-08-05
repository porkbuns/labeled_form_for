class LabeledFormFor::LabeledFormBuilder < ActionView::Helpers::FormBuilder

   ((field_helpers - %w(check_box radio_button hidden_field)) + %w(datetime_select date_select)).each do |selector|
    src = <<-END_SRC
    def #{selector}(field, options = {})
        field_label, info, example = get_label(field, options)
        field_to_html(field_label, field, super, get_errors(field), false, info, example, options)
    end
    END_SRC
    class_eval src, __FILE__, __LINE__
  end

  def select( field, choices, options = {}, html_options = {})
    field_label, info, example = get_label(field, options)
    field_to_html(field_label, field, super, get_errors(field), false, info, example, options)
  end

  def check_box(field, options = {}, checked_value = "1", unchecked_value = "0")
    field_label, info, example = get_label(field, options)
    field_to_html(field_label, field, super, get_errors(field), true, info, example, options)
  end

  def radio_button(field, tag_value, options = {})
    field_label, info, example = get_label(tag_value, options)
    field_to_html(field_label, field, super, get_errors(field), true, info, example, options)
  end

  def submit(text, options)
    @template.submit_tag(text, options)
  end

  def button_group(options={}, &block)
    @template.form_button_group(options, &block)
  end

  def generic_field(label, field_name, field_type = 'text', options = {})
    raise ArgumentError, "options is a Hash" unless options.is_a? Hash
    one_line = options.delete(:is_one_line) || field_type == 'checkbox' || field_type == 'radio'
    info = options.delete(:info)
    example = options.delete(:example)
    error = options.delete(:error) || ''

    field_html = @template.tag(:input, { :type => field_type, :id => "#{@object_name}_#{field_name.to_s.underscore}" }.merge(options))
    field_to_html(label, field_name, field_html, error, one_line, info, example, options)
  end

  protected
  def field_to_html(label, field_name, field_html, error='', is_one_line=false, info=nil, example=nil, options={})
    field_name = "#{@object_name}_#{field_name.to_s.underscore}"
    info_html = (info.nil?) ? '' : @template.content_tag('span',
                                                         info,
                                                         { :class => 'info' }.merge(options[:info_options] || {}))
    example_html = (example.nil?) ? '' : @template.content_tag('div',
                                                               example,
                                                               { :class => 'example' }.merge(options[:example_options] || {}))
    if is_one_line
      li_class = error.blank? ? 'one-line' : 'one-line field-with-errors'
      @template.content_tag('li',
                            field_html +
                            @template.content_tag('label', label,
                                                  { :for => field_name }.merge(options[:label_options] || {})) +
                            info_html + example_html + error,
                            { :class => li_class }.merge(options[:li_options] || {}))
    else
      @template.content_tag('li',
                            @template.content_tag('label', label,
                                                  { :for => field_name }.merge(options[:label_options] || {})) +
                            info_html + field_html + example_html + error,
                            { :class => error.blank? ? nil : 'field-with-errors'}.merge(options[:li_options] || {}))
    end
  end

  def get_label(field, options)
    info = options.delete :info
    example = options.delete :example
    label = options.delete(:label) || field.to_s.humanize.titleize
    return [label, info, example]
  end

  def get_errors(field)
    errors = @object.errors[field]
    field_name = field.to_s.titleize
    if errors.nil? || errors.empty?
      return ''
    elsif errors.is_a? String
      return @template.content_tag(:div, "#{field_name} #{errors}", :class => error)
    else
      return @template.content_tag(:ul, :class => 'errors') do
        errors.each do |e|
          @template.content_tag(:li, "#{field_name} #{e}", :class => 'error')
        end
      end
    end
  end
end
