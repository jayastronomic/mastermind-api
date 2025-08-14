class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username

  def attributes(*args)
    hash = super
    hash.transform_keys { |key| key.to_s.camelize(:lower).to_sym }
  end
end
