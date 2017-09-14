class QuestionResponse < ApplicationRecord
  belongs_to :question_choice
  belongs_to :response

  validates :question_choice, presence: true
  validates :response, presence: true

  delegate :question, to: :question_choice

  # Summarizes the scores for this Question Response by Creative Quality (min, max, raw)
  def summarize
    summary = {}

    # Consider each Question Choice for the Question Response
    self.question.choices.each do |choice|
      
      # Get the name of the Creative Quality this Question Choice relates to
      cq_name = choice.creative_quality.name

      # Initialize the Creative Quality in the summary for this Question Response
      summary[cq_name] ||= {}

      # Update min/max/raw for the Creative Quality for this Question (if necessary)
      summary[cq_name][:min] = choice.score if summary[cq_name][:min] == nil || choice.score < summary[cq_name][:min]
      summary[cq_name][:max] = choice.score if summary[cq_name][:max] == nil || choice.score > summary[cq_name][:max]
      summary[cq_name][:raw] = choice.score if choice == self.question_choice

    end

    return summary
  end
end
