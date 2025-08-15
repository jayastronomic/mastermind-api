module GlobalErrorHandler
  def self.included(clazz)
    clazz.class_eval do
      rescue_from ActiveRecord::RecordInvalid do |exception|
        render json: { message: exception.message, errors: exception.record.errors }, status: :unprocessable_content
      end

      rescue_from InvalidCredentialsError do |exception|
        render json: ResponseEntity.error(message: -> { exception.message }, errors: [ "invalid email/password" ]), status: :unauthorized
      end

      rescue_from UnauthenticatedError do |exception|
        render json: ResponseEntity.error(message: -> { exception.message }, errors: [ "Please log in" ]), status: :forbidden
      end

      rescue_from UnauthorizedError do |exception|
        render json: ResponseEntity.error(message: -> { exception.message }, errors: [ "Unauthorized" ]), status: :unauthorized
      end
    end
  end
end
