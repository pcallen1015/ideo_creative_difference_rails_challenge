class CreativeQuality < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :color, presence: true, uniqueness: true

  # Class variable to store possible "colors"
  @@colors = ['primary', 'success', 'info', 'warning', 'danger']

  before_create :pick_color

  # Randomly assigns a color to the Creative Quality and removes it to prevent duplications
  # Assumption: max of 5 Creative Qualities
  def pick_color
    if @@colors.length > 0
      i = rand(0..@@colors.length-1)
      self.color = @@colors[i]
      @@colors.delete_at(i);
    else
      self.color = 'default'
    end
  end

  # Calculates the average score for this Creative Quality from all Responses
  def average_score
    responses = Response.all
    sum = 0
    count = 0

    responses.each do |response|
      r_summary = response.summarize
      if r_summary[self.name][:nrm]
        sum += r_summary[self.name][:nrm]
        count += 1
      end
    end

    return (sum/count).round
  end

end
