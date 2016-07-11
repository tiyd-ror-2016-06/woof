class RuleForm
  include ActiveModel::Model

  attr_accessor :pattern, :strategies

  validates :pattern, presence: true, length: { maximum: 20 }
  validate :strategies_all_exist

  def model_name
    ActiveModel::Name.new Rule
  end

  def save
    if valid?
      strategy_names.each do |name|
        Pattern.where(
          pattern:  pattern,
          strategy: name
        ).first_or_create!
      end
    end
  end

  private

  def strategies_all_exist
    bad_strategies = strategy_names.reject do |name|
      Handlers.include?(name.to_sym)
    end

    if bad_strategies.any?
      errors.add :strategies, "Unrecognized strategies: #{bad_strategies.to_sentence}"
    end
  end

  def strategy_names
    strategies.split(",").map { |w| w.strip }
  end
end
