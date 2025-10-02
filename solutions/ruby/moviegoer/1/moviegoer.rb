# This is a custom exception that you can use in your code
class NotMovieClubMemberError < RuntimeError
end

class Moviegoer
  OLDER_PRICE = 10
  YOUNGER_PRICE = 15

  PENSION_AGE = 60
  ADULT_AGE = 18

  def initialize(age, member: false)
    @age = age
    @member = member
  end

  def ticket_price
    @age < PENSION_AGE ? YOUNGER_PRICE : OLDER_PRICE
  end

  def watch_scary_movie?
    @age >= ADULT_AGE
  end

  # Popcorn is 🍿
  def claim_free_popcorn!
    raise NotMovieClubMemberError.new unless @member

    '🍿'
  end
end
