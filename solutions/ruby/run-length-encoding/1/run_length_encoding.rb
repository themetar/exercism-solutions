module RunLengthEncoding
  def self.encode(input)
    input
      .scan(/((.)\2*)/)
      .map { |segment, char| "%s%s" % [segment.length > 1 ? segment.length.to_s : '', char] }
      .join
  end

  def self.decode(input)
    input
      .scan(/(\d+)?(.)/)
      .map { |number, char| char * number.to_i.clamp(1..) }
      .join
  end
end
