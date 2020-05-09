module ApplicationHelper
  def bootstrap_class_for flash_type
    {success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info"}[flash_type]
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in ", role: "alert") do
        concat content_tag(:button, 'x', class: "close", data: {dismiss: 'alert'})
        concat message
      end)
    end
    puts("This is testing")
    nil
  end

  def header(text)
    content_for(:header) { text.to_s }
  end
end
