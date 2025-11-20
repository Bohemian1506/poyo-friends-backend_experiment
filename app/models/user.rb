class User < ApplicationRecord
  # Devise モジュール
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # バリデーション
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :target_weight, numericality: { greater_than: 0 }, allow_nil: true
  validates :current_weight, numericality: { greater_than: 0 }, allow_nil: true
end
