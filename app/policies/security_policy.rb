class SecurityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
end
