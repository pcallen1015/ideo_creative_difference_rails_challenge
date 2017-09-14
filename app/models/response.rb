class Response < ApplicationRecord
  has_many :question_responses

  validates :first_name, presence: true
  validates :last_name, presence: true

  delegate :count, to: :question_responses, prefix: true

  def display_name
    "#{first_name} #{last_name}"
  end

  def completed?
    question_responses_count == Question.count
  end

  def summarize
    # Map the Creative Qualities to their various scores
    summary = {}
    
    # Consider each Question Response
    self.question_responses.each do |question_response|
    
      # For each Question Response, map Creative Qualities to min/max/raw scores
      # (Since each Question Choice to potentially point to a DIFFERENT Creative Quality)
      qr_summary = question_response.summarize

      # Update the Summary with scores for the Question Response
      qr_summary.each do |cq_name, scores|
        summary[cq_name] ||= { :raw => 0, :min => 0, :max => 0, :nrm => 0 }
        summary[cq_name][:raw] += scores[:raw]
        summary[cq_name][:min] += scores[:min]
        summary[cq_name][:max] += scores[:max]
      end
    end

    summary.each do |cq_name, scores|
      # ((abs(min) + raw) / (abs(min) + max)) * 100
      min = scores[:min]
      raw = scores[:raw]
      max = scores[:max]
    
      # Calculate the normalized score for the Creative Quality
      scores[:nrm] = (((min.abs + raw).to_f / (min.abs + max).to_f) * 100).round
    end

    return summary
  end

end
