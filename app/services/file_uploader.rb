class FileUploader
  attr_accessor :status, :error_message

  def self.upload(file)
    new()
  end

  def successful?
  end
end
