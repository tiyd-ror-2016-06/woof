class RuleForm
  include ActiveModel::Model

  attr_accessor :pattern, :strategies

  validates :pattern, presence: true, length: { maximum: 20 }
  validate :strategies_all_exist

  def save
    if valid?
      strategies.split(",").each do |name|
        Pattern.where(
          pattern:  pattern,
          strategy: name.strip
        ).first_or_create!
      end
    end
  end

  private

  def strategies_all_exist
    bad_strategies = []
    strategies.split(",").each do |name|
      name = name.strip
      unless Handlers.include?(name.to_sym)
        bad_strategies.push name
      end
    end

    if bad_strategies.any?
      errors.add :strategies, "Unrecognized strategies: #{bad_strategies.to_sentence}"
    end
  end
end
