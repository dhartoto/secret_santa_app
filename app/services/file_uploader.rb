class FileUploader
  attr_accessor :status, :error_message

  def self.upload(file, year)
    year = Year.find_by(year: year) if file
    if year.present? || file.blank? || file.content_type != 'text/csv' || File.zero?(file.tempfile)
      error_message = error_message(file)
      new(status: 400, error_message: error_message)
    else
      File.open(Rails.root.join('public', 'uploads',
        file.original_filename), 'wb') do |content|
          content.write(file.read)
        end
      new(status: 200)
    end
  end

  def initialize(options={})
    @status        = options[:status]
    @error_message = options[:error_message]
  end

  def successful?
    status == 200
  end

  private

  def self.error_message(file)
    if file.blank?
      'No file selected. Please upload a CSV file.'
    elsif file.content_type != 'text/csv'
      'Invalid file. Please upload a CSV file.'
    elsif File.zero?(file.tempfile)
      'File empty. Please add participants and try again.'
    else
      'Participants list for this year already exists.'
    end
  end
end
