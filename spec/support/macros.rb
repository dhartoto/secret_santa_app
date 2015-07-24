def mock_file(options={})
  tempfile = File.new("#{Rails.root}/spec/fixtures/#{options[:file_name]}")
  ActionDispatch::Http::UploadedFile.new(
    tempfile: tempfile,
    filename: options[:file_name],
    type: options[:type] || 'text/csv')
end

def clear_upload_file(file_name)
  file_path = "public/uploads/#{file_name}"
  File.delete(file_path) if File.exist?(file_path)
end
