module Blogg
  module ApplicationHelper
    def notice_message
      alert_types = { :notice => :success, :alert => :danger }

      close_button_options = { :class => "close", "data-dismiss" => "alert", "aria-hidden" => true}
      close_button = content_tag(:button, "×", close_button_options)

      alerts = flash.map do |type, message|
        alert_content = close_button + message

        alert_type = alert_types[type.to_sym] || type
        alert_class = "alert alert-#{alert_type} alert-dismissable"

        content_tag(:div, alert_content, :class => alert_class)
      end

      alerts.join("\n").html_safe
    end
    # Can search for named routes directly in the main app, omitting
    # the "main_app." prefix
  #   def method_missing method, *args, &block
  #    if main_app_url_helper?(method)
  #      main_app.send(method, *args)
  #    else
  #      super
  #    end
  #   end
   #
  #   def respond_to?(method)
  #    main_app_url_helper?(method) or super
  #   end
   #
   #
  #  private
   #
  #   def main_app_url_helper?(method)
  #     (method.to_s.end_with?('_path') or method.to_s.end_with?('_url')) and
  #       main_app.respond_to?(method)
  #   end

  end
end
