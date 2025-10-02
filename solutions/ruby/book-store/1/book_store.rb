# Algorithm:
#
# The number of groups/bundles you can make is the number of the most
# represented (has most copies of) book title in the basket.
# That's because making fewer bundles would require that some bundles
# have two copies of the same book - which is not allowed; and making
# more bundles means that books that could've been combined are in
# separate bundles - which is sub-optimal from the start.
#
# We tally the book titles and sort their count in decreasing order.
# We can imagine that as making stacks of books by title. The
# horizontal slices of books are greedy bundles: going from the
# bottom up we have bundles of five books, then four, etc. This is
# the greedy solution: maximizing the number of biggest bundles
# that could be made.
#
# The only way to recombine the books is to take books from a stack
# and add them to another stack to the left. Moving a book to a
# stack on it's right would, again, put it on a bundle (horizontal layer)
# that already has a book of that title. The number of books to move is
# limited by the height of the stack before the target stack. A book
# needs (n - 1) books before it, to be the "n-th" book. We can't have
# to top of a stack dangle in the air. (Have the tallies become
# unordered.)
#
# So, where should we relocate books? What bundles are to be prioritized?
# We reason about the cost of a book to be the n-th title in a bundle.
# For a two-book bundle, we don't see the price as 2 x 7.6, but as 8
# for the first book and 7.2 for the second book. So on for the third
# book: 15.2 for two books and additional 6.4 for the third. And so on.
# From the given discounts it follows that each 'next' title can be
# bought at smaller cost from the previous, except for the fifth title.
# It's more cost effective to be the fourth book in a bundle than to be
# the fifth. So the only optimization needed to make is move books from
# the fifth stack to the fourth one.
module BookStore
  BOOK_PRICE = 8

  DISCOUNTS = [0, 0.05, 0.1, 0.2, 0.25].freeze

  BUNDLE_PRICE = BOOK_PRICE.step(by: BOOK_PRICE)
                           .take(5)
                           .zip(DISCOUNTS)
                           .map { |total, discount| total * (1 - discount) }
                           .freeze
  # => [8, 15.2, 21.6, 25.6, 30.0]

  # Nth book cost:
  # [BOOK_PRICE] + BUNDLE_PRICE.each_cons(2).map { |a, b| b - a }
  # => [8, 7.2, 6.4, 4.0, 4.4]

  def self.calculate_price(basket)
    book_counts = basket.tally.values.sort.reverse

    if book_counts[4]
      available_slots = book_counts[2] - book_counts[3]
      books_to_move = [book_counts[4], available_slots].min
      book_counts[4] -= books_to_move
      book_counts[3] += books_to_move
    end

    book_counts.each_with_index.sum do |book_count, index|
      bundles = book_count - (book_counts[index + 1] || 0)
      bundles * BUNDLE_PRICE[index]
    end
  end
end
