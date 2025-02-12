class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_one_attached :icon
  validates :first_name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :dob, presence: true
  validates :gender, presence: true
  validates :role, inclusion: { in: ["user", "admin"] }

  # Validate password only if required
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
  validates :password, confirmation: true, if: :password_required?

  def update_without_password(params)
    params.except!(:current_password, :password, :password_confirmation)
    assign_attributes(params)
    valid? ? save(validate: false) : false
  end

  def admin?
    role == "admin"
  end
  private

  def password_required?
    new_record? || password.present? || password_confirmation.present?
  end


end
