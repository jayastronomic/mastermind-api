class GuessSerializer < ActiveModel::Serializer
  attributes :id, :location_match, :number_match, :value

  def attributes(*args)
    hash = super
    hash.transform_keys { |key| key.to_s.camelize(:lower).to_sym }
  end
end
