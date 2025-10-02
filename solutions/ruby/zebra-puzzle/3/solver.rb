# Solver requires a problem domain hash and a rules array
#
#   Domain: { category: [ possible values ... ], ... }
#   Rules: [ lambda, lambda, ... ]
#
# Rule lambdas must return true or false. Their parameters must be named after
# the categories (colors, nationalities, etc.) they relate to.
# Each parameter will be assigned with an ordering of its category to test.
class Solver

  def solution
    return @solution if @solution

    catch :done  do
      nested({}, categories)
    end

    @solution
  end

  private

  attr_accessor :problem_domain, :categories, :rules_per_category

  def initialize(problem_domain, rules)
    self.problem_domain = problem_domain
    self.categories = problem_domain.keys
    self.rules_per_category = categories.to_enum(:to_h).with_index do |category, i|
      [
        category,
        rules.filter do |rule|
          params(rule).then { |tags| tags.include?(category) && (tags - categories[..i]).empty? }
        end
      ]
    end
  end

  def params(proc)
    proc.parameters.map { |_, name| name }
  end

  def test_rule(proc, data)
    proc.call(*params(proc).map(&data))
  end

  def nested(partial, remaining)
    if remaining.empty? # success
      @solution = partial
      throw :done
    end

    category, *rest = remaining

    problem_domain[category].permutation do |ordering|
      partial = partial.merge({ category => ordering })

      next unless rules_per_category[category].all? { |rule| test_rule(rule, partial) }

      nested(partial, rest)
    end
  end

end
