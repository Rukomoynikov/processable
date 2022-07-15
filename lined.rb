class LocationsUploader < Lined::Commander
  configure do |config|
    config.verbose = true
  end

  step :load_csv do
    result = '1'
  end

  step :transform_data, LocationsUploaderStep

  step :save_to_database do
    result_of_load_csv
  end
end

class LocationsUploaderStep < Lined::Step

end

# Order of steps as it's been configured
# In the result you will get either result of the last step
# Print every step (option to disable)
# How to validate?
# Stop if something went wrong
# Steps cannot use the same name