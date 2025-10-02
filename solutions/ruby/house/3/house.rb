module House
  CLAUSES = [
    ['house that Jack built.'],
    ['malt', 'lay in'],
    ['rat', 'ate'],
    ['cat', 'killed'],
    ['dog', 'worried'],
    ['cow with the crumpled horn', 'tossed'],
    ['maiden all forlorn', 'milked'],
    ['man all tattered and torn', 'kissed'],
    ['priest all shaven and shorn', 'married'],
    ['rooster that crowed in the morn', 'woke'],
    ['farmer sowing his corn', 'kept'],
    ['horse and the hound and the horn', 'belonged to']
  ]

  def self.recite(from_line, to_line)
    compound = ''
    CLAUSES[...to_line].map do |object, verb|
      compound = object + (verb ? " that #{verb} the #{compound}" : '')
      'This is the ' + compound + "\n"
    end
    .drop(from_line - 1)
    .join
  end
  
end
