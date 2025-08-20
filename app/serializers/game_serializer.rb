class GameSerializer < ActiveModel::Serializer
  attributes :id, :status, :user_id, :solution
  has_many :guesses

  def attributes(*args)
    hash = super
    hash.transform_keys { |key| key.to_s.camelize(:lower).to_sym }
  end

  def solution
    object.solution if object.status != "in_progess"
  end
end
