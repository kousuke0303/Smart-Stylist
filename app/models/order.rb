class Order < ApplicationRecord
  belongs_to :client
  belongs_to :user
  include OrdersHelper
  has_one_attached :img_1
  has_one_attached :img_2
  has_one_attached :img_3
  has_one_attached :img_4
  has_one_attached :img_5
  has_one_attached :img_6
  has_one_attached :img_7
  has_one_attached :img_8
  
  attr_accessor :del_img_1, :del_img_2, :del_img_3, :del_img_4, :del_img_5, :del_img_6, :del_img_7, :del_img_8, :narrow
  before_save { total_unpaid(self) > 0 ? self.unpaid = true : self.unpaid = false }
  before_save { self.retail = self.retail.to_i }
  before_save { self.retail.to_i == self.deposit.to_i && self.sold_on.present? ? self.traded = true : self.traded = false }
  before_save { self.note = nil if !note.nil? && note.match(ONLY_SPACE_REGEX) }
  before_save { self.img_1_note = nil if !img_1_note.nil? && img_1_note.match(ONLY_SPACE_REGEX) }
  before_save { self.img_2_note = nil if !img_2_note.nil? && img_2_note.match(ONLY_SPACE_REGEX) }
  before_save { self.img_3_note = nil if !img_3_note.nil? && img_3_note.match(ONLY_SPACE_REGEX) }
  before_save { self.img_4_note = nil if !img_4_note.nil? && img_4_note.match(ONLY_SPACE_REGEX) }
  before_save { self.img_5_note = nil if !img_5_note.nil? && img_5_note.match(ONLY_SPACE_REGEX) }
  before_save { self.img_6_note = nil if !img_6_note.nil? && img_6_note.match(ONLY_SPACE_REGEX) }
  before_save { self.img_7_note = nil if !img_7_note.nil? && img_7_note.match(ONLY_SPACE_REGEX) }
  before_save { self.img_8_note = nil if !img_8_note.nil? && img_8_note.match(ONLY_SPACE_REGEX) }
  
  validates :kind, presence: true
  validates :plant_id, presence: true
  validates :client_id, presence: true
  validates :ordered_on, presence: true
  validates :retail, presence: true
  validates :deposit, numericality: { only_integer: true, greater_than: 0, less_than: 10_000_000 }, allow_blank: true
  validates :wage, numericality: { only_integer: true, greater_than: 0, less_than: 10_000_000 }, allow_blank: true
  validates :cloth, numericality: { only_integer: true, greater_than: 0, less_than: 10_000_000 }, allow_blank: true
  validates :lining, numericality: { only_integer: true, greater_than: 0, less_than: 10_000_000 }, allow_blank: true
  validates :button, numericality: { only_integer: true, greater_than: 0, less_than: 10_000_000 }, allow_blank: true
  validates :postage, numericality: { only_integer: true, greater_than: 0, less_than: 10_000_000 }, allow_blank: true
  validates :other, numericality: { only_integer: true, greater_than: 0, less_than: 10_000_000 }, allow_blank: true
  validates :note, length: { maximum: 100 }
  validates :img_1_note, length: { maximum: 40 }
  validates :img_2_note, length: { maximum: 40 }
  validates :img_3_note, length: { maximum: 40 }
  validates :img_4_note, length: { maximum: 40 }
  validates :img_5_note, length: { maximum: 40 }
  validates :img_6_note, length: { maximum: 40 }
  validates :img_7_note, length: { maximum: 40 }
  validates :img_8_note, length: { maximum: 40 }
  
  validate :ratail_rule
  validate :deposit_limit
  validate :ordered_on_than_sold_on_fast_if_invalid
  validate :ordered_on_than_delivered_on_fast_if_invalid
  validate :invalid_pay_without_cost
  validate :note_with_img
  
  def ordered_on_than_sold_on_fast_if_invalid
    errors.add(:ordered_on, "より早い売上日は無効です") if ordered_on.present? && sold_on.present? && ordered_on > sold_on
  end
  
  def ordered_on_than_delivered_on_fast_if_invalid
    errors.add(:ordered_on, "より早い納品予定日は無効です") if ordered_on.present? && delivered_on.present? && ordered_on > delivered_on
  end
  
  def invalid_pay_without_cost
    errors.add(:wage, "の金額を入力してください") if wage.nil? && wage_pay.present?
    errors.add(:cloth, "の金額を入力してください") if cloth.nil? && cloth_pay.present?
    errors.add(:lining, "の金額を入力してください") if lining.nil? && lining_pay.present?
    errors.add(:button, "の金額を入力してください") if button.nil? && button_pay.present?
    errors.add(:postage, "の金額を入力してください") if postage.nil? && postage_pay.present?
    errors.add(:other, "の金額を入力してください") if other.nil? && other_pay.present?
  end
  
  def ratail_rule
    errors.add(:retail, "は数値で入力してください") if retail.present? && retail !~ /^[0-9]+$/
    errors.add(:retail, "は1〜9999999までの値にしてください") unless retail.to_i.between?(1, 9_999_999)
    errors.add(:retail, "が費用に対して不足しています") if retail.present? && total_cost(self) > self.retail.to_i && retail =~ /^[0-9]+$/
  end
  
  def deposit_limit
    errors.add(:deposit, "は上代以内にしてください") if deposit.to_i > retail.to_i && retail =~ /^[0-9]+$/
  end
  
  def note_with_img
    errors.add(:img_1, "が登録されていません") if !img_1.attached? && img_1_note.present?
    errors.add(:img_2, "が登録されていません") if !img_2.attached? && img_2_note.present?
    errors.add(:img_3, "が登録されていません") if !img_3.attached? && img_3_note.present?
    errors.add(:img_4, "が登録されていません") if !img_4.attached? && img_4_note.present?
    errors.add(:img_5, "が登録されていません") if !img_5.attached? && img_5_note.present?
    errors.add(:img_6, "が登録されていません") if !img_6.attached? && img_6_note.present?
    errors.add(:img_7, "が登録されていません") if !img_7.attached? && img_7_note.present?
    errors.add(:img_8, "が登録されていません") if !img_8.attached? && img_8_note.present?
  end
end
