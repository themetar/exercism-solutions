class ResistorColorDuo
  VALUES_HASH = %w(black brown red orange yellow green blue violet grey white).zip(0...9).to_h

  def self.value(codes)
    VALUES_HASH[codes[0]] * 10 + VALUES_HASH[codes[1]]
  end
end
