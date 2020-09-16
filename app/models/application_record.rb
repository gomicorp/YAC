class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.sandbox
    # Start transaction
    connection.begin_transaction(joinable: false)
    puts '🆒 Sandbox Mode: ON 🆒'.gray

    # Run your task
    yield if block_given?

    # Teardown
    # at_exit {}
    puts 'Rolling back......'.gray
    connection.rollback_transaction
    puts 'Roll back complete....'.gray
  end
end
