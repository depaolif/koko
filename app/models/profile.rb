class Profile < ApplicationRecord
  belongs_to :account
  validate :validate_form_input

  private

  def validate_form_input
    if !self.name.scan(/[<>]/).empty?
      errors.add(:name, "Don't try to pull a fast one on us.")
    elsif !self.bio.scan(/[<>]/).empty?
      errors.add(:bio, "Don't try to pull a fast one on us.")
    elsif !self.interests.scan(/[<>]/).empty?
     errors.add(:interests, "Don't try to pull a fast one on us.")
    end
  end

end
