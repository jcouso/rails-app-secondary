class SecurityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def show?
    true
  end

  def update?
    user_is_owner?
  end

  def destroy?
    user_is_owner?
  end

  def edit?
    user_is_owner?
  end

  def search?
    true
  end

  private

  def user_is_owner?
    record.user == user
  end
end
