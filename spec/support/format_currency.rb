# frozen_string_literal: true

module FormatCurrency
  def format_currency(value)
    case CsIss::Config.locale
    when "pt-BR"
      integer_part, decimal_part = value.split(",")
      integer_part_with_separator = integer_part.reverse.gsub(/(\d{3})(?=\d)/,
                                                              '\\1.').reverse
      "R$ #{integer_part_with_separator},#{decimal_part}"
    else
      value
    end
  end
end
