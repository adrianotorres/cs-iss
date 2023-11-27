# frozen_string_literal: true

module I18nTestHelpers
  def form_label(form, label)
    I18n.t(label, scope: "activemodel.attributes.#{form}")
  end

  def form_error(form, error)
    I18n.t(error, scope: "activemodel.errors.models.#{form}")
  end

  def model_label(model, label)
    I18n.t(label, scope: "activerecord.attributes.#{model}")
  end

  def t(scope)
    I18n.t(scope)
  end
end
