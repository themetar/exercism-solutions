class Triangle

  attr_reader :rows

  private

  def initialize(row_count)
    @rows = []

    @rows << [1] if row_count > 0

    (row_count - 1).times do
      @rows << generate_row(@rows.last)
    end
  end

  def generate_row(previous_row)
    [0, *previous_row, 0].each_cons(2).map { |left, right| left + right }
  end

end
