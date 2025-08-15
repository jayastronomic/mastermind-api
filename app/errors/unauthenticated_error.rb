class UnauthenticatedError < StandardError
    def message
        "User is not logged in"
    end
end
