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

end
