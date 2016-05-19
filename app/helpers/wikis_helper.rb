module WikisHelper
  def user_is_authorized_to_delete_wiki?
    current_user == @wiki.user || current_user.admin?
  end
end
