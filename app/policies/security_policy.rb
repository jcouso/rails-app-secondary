class SecurityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user_is_owner?
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

  private

  def user_is_owner?
    record_user == user
  end
end
