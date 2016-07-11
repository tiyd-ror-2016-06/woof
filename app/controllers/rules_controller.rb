class RulesController < ApplicationController
  def new
    @rule = RuleForm.new
  end

  def create
    @rule = RuleForm.new rule_params
    if @rule.save
      redirect_to root_path, notice: "Rule saved"
    else
      render :new
    end
  end

  private

  def rule_params
    params.require(:rule_form).permit(:pattern, :strategies)
  end
end
