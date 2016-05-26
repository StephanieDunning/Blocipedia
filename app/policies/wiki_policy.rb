class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def show?
    record.public || (user.admin? || user.premium? || record.user == user)
  end

  def user?
    user.present?
  end

  def index?
    true
  end

  def create?
    true
  end

  def edit?
    user.present?
  end

  def update?
    user.present || user.admin
  end

  def destroy?
    user.present || user.admin
  end
end
