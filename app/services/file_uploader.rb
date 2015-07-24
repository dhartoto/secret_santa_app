class FileUploader
  attr_accessor :status, :error_message

  def self.upload(file)
    File.open(Rails.root.join('public', 'uploads',
      file.original_filename), 'wb') do |content|
        content.write(file.read)
      end
    new(status: 200)
  end

  def initialize(options={})
    @status = options[:status]
  end

  def successful?
  end
end
