class RentalPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def create?
    user
  end

  def update?
    show?
  end

  def show?
    record.user == user || record.garage.user == user
  end
end
