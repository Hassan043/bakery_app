class Product < ApplicationRecord
  belongs_to :category
  
  scope :by_name,     ->(q) { where("name ILIKE ?", "%#{q}%") if q.present? }
  scope :by_category, ->(c) { where(category_id: c)        if c.present? }

  # Handle image upload and storage
  def image=(uploaded_file)
    if uploaded_file.present?
      # Create uploads directory if it doesn't exist
      uploads_dir = Rails.root.join('public', 'uploads', 'products')
      FileUtils.mkdir_p(uploads_dir) unless Dir.exist?(uploads_dir)
      
      # Generate unique filename
      filename = "#{SecureRandom.uuid}_#{uploaded_file.original_filename}"
      file_path = uploads_dir.join(filename)
      
      # Save file
      File.open(file_path, 'wb') do |file|
        file.write(uploaded_file.read)
      end
      
      # Store relative path in database
      self.image_path = "/uploads/products/#{filename}"
    end
  end

  def image
    # Return the image path for display
    image_path
  end
  def has_image?
    image_path.present? && File.exist?(Rails.root.join('public', image_path.gsub(/^\//, '')))
  end
  
  def image_url
    image_path.present? ? image_path : nil
  end
end
