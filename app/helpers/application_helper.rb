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

  def dollarize(number)
    "$#{number}"
  end
end
