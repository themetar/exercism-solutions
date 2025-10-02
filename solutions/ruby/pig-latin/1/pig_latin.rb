module PigLatin
  def self.translate(text)
    text.split.map do |word|
      case word
      when /^([aeiou]|yt|xr)/
        word + 'ay'
      when /^([^aeiouq]*qu|[^aeiou]+)([aeiouy].*)$/
        $2 + $1 + 'ay'
      end
    end .join(' ')
  end
end
