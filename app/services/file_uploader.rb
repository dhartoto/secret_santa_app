class FileUploader
  attr_accessor :status, :error_message

  def self.upload(file_name)
    new()
  end
end
