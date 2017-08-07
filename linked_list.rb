class LinkedList

  include Enumerable

  class Node
    attr_reader :data, :tail
    def initialize(data, tail)
      @data = data
      @tail = tail
      freeze
    end
  end

  attr_reader :head

  def initialize(element)
    @head = if element.is_a? Node
              element
            else
              Node.new(element, nil)
            end
    freeze
  end

  def peek
    head.data
  end
  alias_method :first, :peek

  def last
    reverse.peek
  end

  def next
    head.tail && LinkedList.new(head.tail)
  end
  [ :tail, :pop ].each { |aka| alias_method aka, :next }

  def next?
    !!head.tail
  end

  def pop_n(num)
    return if num >= length
    list = self
    num.times { list = list.pop }
    list
  end

  def prepend(element)
    LinkedList.new(Node.new(element, head))
  end
  [ :insert, :push, :add_first, :add ].each { |aka| alias_method aka, :prepend }

  def append(element)
    reverse.prepend(element).reverse
  end
  alias_method :add_last, :append

  def value_at(index)
    return nil if index >= length
    list = self
    index.times do
      list = list.next
    end
    list.peek
  end

  def insert_at(index, object)
    return prepend(object) unless index.positive?
    return append(object) if index > length

    list = self
    traversed_elements = LinkedList.new(list.peek)
    (index).times do
      list = list.next
      traversed_elements = traversed_elements.prepend(list.peek)
    end

    list = list.prepend(object)
    while traversed_elements.next?
      traversed_elements = traversed_elements.next
      list = list.prepend(traversed_elements.peek)
    end
    list
  end

  def insert_before(index, object)
    insert_at(index - 1, object)
  end

  def insert_after(index, object)
    insert_at(index + 1, object)
  end

  def add_all(enumerable)
    enumerable.reverse_each.inject(self) { |list, item| list = list.push(item) }
  end

  def delete(object)
    return self if !contains? object
    return self.next if peek == object

    list = self
    traversed_elements = LinkedList.new(list.peek)

    while list.next?
      list = list.next

      if list.peek == object
        if list.next?
          list = list.next
          traversed_elements = traversed_elements.prepend(list.peek)
          break
        else
          return traversed_elements.reverse
        end
      end

      traversed_elements = traversed_elements.prepend(list.peek)
    end

    while traversed_elements.next?
      traversed_elements = traversed_elements.next
      list = list.prepend(traversed_elements.peek)
    end

    list
  end

  def delete_at(index)
    return pop if index.zero?
    return reverse.pop.reverse if index == (length - 1)
    return self if index.negative? || index >= length

    list = self
    traversed_elements = LinkedList.new(list.peek)

    (index).times do
      list = list.next
      traversed_elements = traversed_elements.prepend(list.peek)
    end

    list = list.next

    while traversed_elements.next?
      traversed_elements = traversed_elements.next
      list = list.prepend(traversed_elements.peek)
    end

    list
  end

  def contains?(object)
    return false if object.nil?

    list = self

    return true if list.peek == object

    while list.next?
      list = list.next
      return true if list.peek == object
    end

    false
  end

  def length
    return 0 if peek.nil? && !next?
    list = self
    node_count = 1
    while list.next?
      node_count += 1
      list = list.next
    end
    node_count
  end

  def reverse
    forward = self
    reversed = LinkedList.new(forward.peek)
    while forward.next?
      forward = forward.next
      reversed = reversed.prepend(forward.peek)
    end
    reversed
  end

  def each(&block)
    enum = Enumerator.new do |y|
      list = self
      y << list.peek

      while list.next?
        list = list.next
        y << list.peek
      end
    end
    if block_given?
      enum.each(&block)
    else
      enum
    end
  end

  def to_s
    "#{map(&:to_s).join(", ")}"
  end
end
