module GlobalErrorHandler
  def self.included(clazz)
    clazz.class_eval do
      rescue_from ActiveRecord::RecordInvalid do |exception|
        render json: { message: exception.message, errors: exception.record.errors }, status: :unprocessable_content
      end
    end
  end
end
