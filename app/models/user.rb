# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  image_url              :string(255)
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string(255)
#  name                   :string(255)      default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :trackable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :identities, class_name: 'OmniAuthIdentity', dependent: :destroy
  has_many :comments, foreign_key: :author_id
  has_many :admin_permissions, class_name: 'OrganizationAdminPermission', foreign_key: :admin_id
  has_many :organizations, through: :admin_permissions

  has_one_attached :profile_image


  ###
  # Facebook Auth
  #
  def self.find_for_oauth(auth, signed_in_resource = nil)

    # user와 identity가 nil이 아니라면 받는다

    identity = OmniAuthIdentity.find_for_oauth(auth)
    user = signed_in_resource || identity.user

    user ||=
      if where(email: auth.info.email).exists?
        user.identities.create!(provider: auth.provider, uid: auth.uid)
      else
        create! do |user|
          user.name = auth.info.name
          user.email = auth.info.email || "#{auth.provider}#{auth.uid}-#{auth.name.parameterize}@yac.fake"
          user.image_url = auth.info.image

          passwd = Devise.friendly_token[0, 20]
          user.password = passwd
          user.password_confirmation = passwd

          user.identities.new(provider: auth.provider, uid: auth.uid)

          user.skip_confirmation!
        end
      end

    user
  end

  # email이 없어도 가입이 되도록 설정

  def email_required?
    false
  end

  # === Act as organization admin
  #
  def admin_of?(organization)
    organizations.where(id: organization).exists?
  end
end
