module ApplicationHelper
  def full_title(title = '')
    base_title = 'BullStock'
    title.empty? ? base_title : "#{title} | #{base_title}"
  end

  def get_email_username(email)
    email.split('@')[0]
  end

  def format_auxiliary_verb(count)
    count == 1 ? 'is' : 'are'
  end

  def display_purchase_or_search
    current_user.approved? ? 'Purchase' : 'Search'
  end

  def change_bg_if_admin_or_trader
    if !current_user || current_user&.trader?
      'bg-green-600'
    else
      'bg-blue-600'
    end
  end

  def change_text_color_if_admin_or_trader
    if current_user&.trader?
      'text-green-200 hover:text-green-100'
    else
      'text-blue-200 hover:text-blue-100'
    end
  end

  def stock_to_red_or_green(text)
    text == 'buy' ? 'text-green-600' : 'text-red-600'
  end

  def balance_to_red_or_green(text)
    text == 'deposit' ? 'text-green-600' : 'text-red-600'
  end
end
