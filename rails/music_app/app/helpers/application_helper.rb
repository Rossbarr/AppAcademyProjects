module ApplicationHelper
  def auth_token
    html = "<input"
    html += "type='hidden'"
    html += "name='authenticity_token'"
    html += "value='#{form_authenticity_token}'>"

    html.html_safe
  end
end
