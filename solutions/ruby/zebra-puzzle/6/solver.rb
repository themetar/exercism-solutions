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
    return result if result

    catch :done  do
      nested({}, categories)
    end

    result
  end

  private

  attr_accessor :problem_domain, :categories, :rules_per_category, :result

  def initialize(problem_domain, rules)
    self.problem_domain = problem_domain
    self.categories = problem_domain.keys
    self.rules_per_category = rules.group_by do |rule|
      parameter_names(rule).max_by(&categories.method(:index))
    end
  end

  def parameter_names(procedure)
    procedure.parameters.map { |_, name| name }
  end

  def test(procedure, data)
    procedure.call(*parameter_names(procedure).map(&data))
  end

  def nested(partial, remaining)
    if remaining.empty? # success
      self.result = partial
      throw :done
    end

    category, *rest = remaining

    problem_domain[category].permutation do |ordering|
      partial = partial.merge({ category => ordering })

      next unless rules_per_category[category].all? { |rule| test(rule, partial) }

      nested(partial, rest)
    end
  end

end
