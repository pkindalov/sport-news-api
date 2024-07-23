# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar, dependent: :destroy

  EMAIL_REGEX = %r{\A(?=[a-z0-9@.!#$%&'*+\-/=?^_`{|}~]{6,254}\z)(?=[a-z0-9.!#$%&'*+\-/=?^_`{|}~]{1,64}@)[a-z0-9!#$%&'*+\-/=?^_`{|}~]+(?:\.[a-z0-9!#$%&'*+\-/=?^_`{|}~]+)*@(?:(?=[a-z0-9\-]{1,63}\.)[a-z0-9](?:[a-z0-9\-]*[a-z0-9])?\.)+(?=[a-z0-9\-]{1,63}\z)[a-z0-9](?:[a-z0-9\-]*[a-z0-9])?\z}i
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }, if: :password
end
