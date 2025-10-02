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

  def self.recite
    compound = ''
    CLAUSES.map do |object, verb|
      compound = object + "\n" + (verb ? "that #{verb} the #{compound}" : '')
      'This is the ' + compound
    end
    .join("\n")
  end
  
end
