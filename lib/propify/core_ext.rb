String.class_eval do
  def to_strung
    "SUPER #{self}".strip
  end
end