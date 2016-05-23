class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :wikis

  enum role: [:standard, :premium, :admin]

  before_save { self.role ||= :standard}

  def standard?
    role == "standard"
  end

  def premium?
    role == "premium"
  end

  def admin?
    role == "admin"
  end

  def downgrade
    self.update_attribute(:role, :standard)
  end
end
