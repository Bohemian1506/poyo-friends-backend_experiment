class User < ApplicationRecord
  # Devise モジュール
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # コールバック
  before_validation :normalize_oauth_fields

  # バリデーション
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :target_weight, numericality: { greater_than: 0 }, allow_nil: true
  validates :current_weight, numericality: { greater_than: 0 }, allow_nil: true

  # provider/uid はペアで存在させる
  validates :provider, presence: true, if: -> { uid.present? }
  validates :uid,       presence: true, if: -> { provider.present? }

  private

  # OAuth関連フィールドの正規化
  # 空文字や空白だけの文字列を nil に変換する
  def normalize_oauth_fields
    self.provider = nil if provider.blank?
    self.uid      = nil if uid.blank?
  end
end
