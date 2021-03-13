module ApplicationHelper
  def auth_token
    html = "<input "
    html += "type='hidden' "
    html += "name='authenticity_token' "
    html += "value='#{form_authenticity_token}'>"

    html.html_safe
  end

  def login_or_logout
    if current_user.nil?
      html =  "<ul>"
      html += "  <li>"
      html += "    <a href='#{new_session_url}'>Log in!</a>"
      html += "  </li>"
      html += "  <li>"
      html += "    <a href='#{new_user_url}'>Sign up!</a>"
      html += "  </li>"
      html += "</ul>"
    else
      html =  "<ul>"
      html += "  <li>"
      html += "    <a href='#{user_url(current_user)}'>#{current_user.username}</a>"
      html += "  </li>"
      html += "  <li>"
      html += "    <form action='#{session_url}' method='POST'>"
      html += "      <input type='hidden' name='_method' value='delete'>"
      html += "      #{auth_token}"
      html += "      <input type='submit' value='Log out'>"
      html += "    </form>"
      html += "  </li>"
      html += "</ul>"
    end

    html.html_safe
  end
end
