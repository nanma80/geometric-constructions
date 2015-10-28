class Entity
  attr_reader :id, :definition

  def initialize(*args)
    @id = nil
    @definition = {}
  end

  def id=(new_id)
    if @id.nil?
      @id = new_id
    else
      raise 'id cannot be assigned twice'
    end
  end

  def definition=(definition)
    if @definition.empty?
      @definition = definition
    else
      raise 'definition cannot be assigned twice'
    end
  end
end