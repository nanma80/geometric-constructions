require 'pp'

class Entity
  attr_reader :id, :definition

  def initialize(*args)
    @definition = {}
  end

  def description
  end

  def print
    predicate = ''

    definition.each do |verb, entities|
      unless predicate.empty?
        predicate += ' and'
      end
      predicate += " #{verb.to_s.gsub(/_/, ' ')}"

      entities_strings = []
      entities.each do |entity|
        if entity.id.nil?
          entity.print
        end

        entities_strings << " #{entity.class} \##{entity.id}"
      end

      predicate += entities_strings.join(',')
    end

    set_id
    puts "#{self.class} \##{id}#{predicate}. #{description}"
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