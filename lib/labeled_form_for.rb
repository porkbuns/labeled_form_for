require "labeled_form_for/version"

module LabeledFormFor
  autoload :LabeledFormBuilder, "labeled_form_for/labeled_form_builder"
  autoload :LabeledFormHelper, "labeled_form_for/labeled_form_helper"
end

ActionView::Base.send :include, LabeledFormFor::LabeledFormHelper
