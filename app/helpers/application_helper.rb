module ApplicationHelper
  include ActionView::Helpers::NumberHelper

  def humanize_size(size)
    if size < 1024
      "#{number_with_delimiter(size, delimiter: ',')} Bytes"
    else
      "#{number_to_human_size(size)} (#{number_with_delimiter(size, delimiter: ',')} Bytes)"
    end
  end
end
