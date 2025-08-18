class GameSerializer < ActiveModel::Serializer
  attributes :id, :status, :user_id, :solution
  has_many :guesses

  def attributes(*args)
    hash = super
    hash.transform_keys { |key| key.to_s.camelize(:lower).to_sym }
  end

  def solution
    object.solution if object.guesses.length == 10
  end
end
