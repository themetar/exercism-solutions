module PhoneNumber
  def self.clean(input)
    # /  ^  [^\d]*  1?  [^\d]*  ([2-9]\d{2})  [^\d]*  ([2-9]\d{2})  [^\d]*  (\d{4})  [^\d]*  $  /
    #
    # 1.  start of string
    # 2.  zero or more non-digits
    # 3.  optional '1'
    # 4.  non-digits
    # 5.  first group of NXX
    # 6.  non-digits
    # 7.  second group of NXX
    # 8.  non-digits
    # 9.  last group of XXXX
    # 10. non-digits
    # 11. end of string

    if input =~ /^[^\d]*1?[^\d]*([2-9]\d{2})[^\d]*([2-9]\d{2})[^\d]*(\d{4})[^\d]*$/  # if string matches
      $1 + $2 + $3    # concatenate groups
    end
  end
end