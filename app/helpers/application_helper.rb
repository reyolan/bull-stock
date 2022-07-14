module ApplicationHelper
  def full_title(title = "")
    base_title = "BullStock"
    title.empty? ? base_title : "#{title} | #{base_title}"
  end

  def get_email_username(email)
    email.split("@")[0]
  end

  def format_auxiliary_verb(count)
    count == 1 ? "is" : "are"
  end

  def display_purchase_or_search
    current_user.approved? ? "Purchase" : "Search"
  end

  def change_bg_if_admin_or_trader
    if !current_user || current_user&.trader?
      "bg-gray-800"
    else
      "bg-blue-600"
    end
  end

  def change_text_color_if_admin_or_trader
    if current_user&.trader?
      "text-gray-300 hover:text-gray-100"
    else
      "text-blue-200 hover:text-blue-100"
    end
  end

  def stock_to_red_or_green(text)
    text == "buy" ? "text-green-600" : "text-red-600"
  end

  def balance_to_red_or_green(text)
    text == "deposit" ? "text-green-600" : "text-red-600"
  end

  def show_svg(path)
    File.open("app/assets/images/#{path}", "rb") do |file|
      raw file.read
    end
  end

  def app_background
    if current_user&.admin?
      "bg-slate-200"
    else
      "bg-gradient-to-br from-gray-900 to-gray-600 bg-gradient-to-r"
    end
  end
end
