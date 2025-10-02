module Bob
  def self.hey(remark)
    is_question = remark =~ /\?\s*\z/
    is_loud = remark =~ /[A-Z]/ && !(remark =~ /[a-z]/)
    is_silence = remark =~ /^\s*\z/

    if is_question && is_loud then "Calm down, I know what I'm doing!"
    elsif is_question         then "Sure."
    elsif is_loud             then "Whoa, chill out!"
    elsif is_silence          then "Fine. Be that way!"
    else
      "Whatever."
    end
  end
end
    