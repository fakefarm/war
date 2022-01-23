class Payload
  attr_accessor :data

  def initialize(data: [], errors: [])
    @data = data
    @errors = initialize_errors(errors)
  end

  def initialize_errors(e)
    errors = if e.respond_to?(:unshift)
               e
             else
               [e]
             end
  end

  def data?
    @data.present?
  end

  def errors?
    @errors.present?
  end

  attr_reader :errors

  def errors=(e)
    @errors << e
  end
end
