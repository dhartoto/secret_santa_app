class FileUploader
  attr_accessor :status, :error_message

  def self.upload(file)
    Validator.validate(file)
    new()
  end

  def successful?
  end
end
