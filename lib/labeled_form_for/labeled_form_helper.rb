# 01:02 12/23/2007 DarkWulf
# In upgrading to Rails 2.0 (from 1.2), end_form_tag was deprecated.
# For now, just use '<form>'
module LabeledFormFor::LabeledFormHelper
  def labeled_form_for(name, object, *args, &block )
    raise ArgumentError, "Missing block" unless block_given?
    options = (args.last.is_a?(Hash) ? args.pop : {})
    class_name = options.has_key?(:class) ? options.delete(:class) : 'form-container'
    form_tag(options.delete(:url) || {}, options.delete(:html) || {}) do
      content_tag(:ul, :class => class_name) do
        fields_for(name, object, { :builder => ::LabeledFormFor::LabeledFormBuilder }, &block )
      end
    end
  end

  def remote_labeled_form_for( name, *args, &block )
    raise ArgumentError, "Missing block" unless block_given?
    options = (args.last.is_a?(Hash) ? args.pop : {}).merge(:builder => ::LabeledFormFor::LabeledFormBuilder)
    class_name = options.has_key?(:class) ? options.delete(:class) : 'form-container'
    concat(%Q|<ul class="#{class_name}">|.html_safe)
    remote_form_for( name, *(args<< options), &block )
    concat('</ul>'.html_safe)
  end
  alias :labeled_form_remote_for :remote_labeled_form_for

  def form_button_group(options={}, &block)
    raise ArgumentError, "Missing block" unless block_given?
    class_name = options.has_key?(:class) ? options.delete(:class) : 'button-group'
    content_tag(:li, :class => class_name, &block)
  end
end
