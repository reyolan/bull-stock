module ApplicationHelper
  def full_title(title = '')
    base_title = 'BullStock'
    title.empty? ? base_title : "#{title} | #{base_title}"
  end

  def get_email_username(email)
    email.split('@')[0]
  end
end
