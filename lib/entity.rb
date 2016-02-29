require 'pp'

class Entity
  attr_reader :id, :definition

  def initialize(*args)
    @definition = {}
  end

  def description
  end

  def with_name(name)
    definition[:name] = [name]
    self
  end

  def has_name?
    definition.has_key?(:name)
  end

  def name
    definition[:name].first
  end

  def is_predefined?
    definition.has_key?(:is_predefined)
  end

  def print
    predicate = ''

    if is_predefined?
      if has_name?
        predicate += " is the #{name}"
      else
        predicate = ' is predefined'
      end

    else
      definition.each do |verb, entities|
        unless predicate.empty?
          predicate += ' and'
        end
        predicate += " #{verb.to_s.gsub(/_/, ' ')}"

        entities_strings = []
        entities.each do |entity|
          if !definition.has_key?(:is_predefined) && entity.id.nil?
            entity.print
          end

          entities_strings << " #{entity.class} \##{entity.id}"
        end

        predicate += entities_strings.join(',')
      end
    end

    set_id
    puts "\# #{self.class} \##{id}#{predicate}. #{description}"
  end

  def set_id
    @id = Entity.next_id
  end

  def self.next_id
    @@next_id ||= -1
    @@next_id += 1
    @@next_id
  end
end