class ResponseEntity
  attr_reader :data, :message, :status, :errors


  def initialize(data:, message:, status:, errors:)
    @data = data
    @status = status
    @message = message
    @errors = errors
  end

  private_class_method :new

    def self.success(data:, message:)
      create(data: data, message: message, status: "success", errors: nil)
    end


    def self.error(message:, errors:)
      create(data: nil, message: message, status: "error", errors: errors)
    end

    private

    def self.create(data:, message:, status:, errors:)
      new(data: data, message: message.call, status: status, errors: errors)
    end
end
