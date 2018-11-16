module Lexicon
  def self.convert_number(obj)
    begin
      return Integer(obj)
    rescue
      return nil
    end
  end

  def self.scan(sentence)
    words = sentence.split
    directions = ["north", "south", "east", "west", "down", "up", "left", "right", "back"]
    verbs = ["go", "kill", "eat"]
    stop = ['the', 'in', 'of']
    nouns = ['bear', 'princess']
    result = []

    words.each do | word |
      number = convert_number(word)
      if number
        result.push(["number", number])
      elsif directions.include?(word.downcase)
        result.push(["direction", word])
      elsif verbs.include?(word.downcase)
        result.push(["verb", word])
      elsif stop.include?(word.downcase)
        result.push(["stop", word])
      elsif nouns.include?(word.downcase)
        result.push(["noun", word])
      else
        result.push(["error", word])
      end
    end

    result
  end
end