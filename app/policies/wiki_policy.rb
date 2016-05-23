class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki
  
  def user?
    user.present?
  end

  def index?
    true
  end

  def edit?
    user.present?
  end
end
