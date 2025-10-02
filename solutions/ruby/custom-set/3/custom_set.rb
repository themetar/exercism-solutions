class CustomSet
  def initialize(elements = [])
    @members = {}

    elements.each { |e| add(e) }
  end

  def empty?
    @members.size.zero? # or simply @members.empty?
  end

  def member?(element)
    @members.include? element
  end

  def subset?(other)
    @members.all? { |member, _| other.member? member }
  end

  def disjoint?(other)
    @members.none? { |member, _| other.member? member }
  end

  def size
    @members.size
  end

  def ==(other)
    size == other.size && subset?(other)
  end

  def each(&block)
    return to_enum unless block_given?

    @members.each_key(&block)

    self
  end

  def add(element)
    @members[element] = :present
    self
  end

  def intersection(other)
    each.with_object(CustomSet.new) { |member, result| result.add(member) if other.member? member }
  end

  def difference(other)
    each.with_object(CustomSet.new) { |member, result| result.add(member) unless other.member? member }
  end

  def union(other)
    CustomSet.new(each + other.each)
  end  
end
