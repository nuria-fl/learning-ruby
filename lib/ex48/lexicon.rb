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
    dictionary = {
      direction: ["north", "south", "east", "west", "down", "up", "left", "right", "back"],
      verb: ["go", "kill", "eat"],
      stop: ['the', 'in', 'of'],
      noun: ['bear', 'princess']
    }

    words.map do | word |
      number = convert_number(word)
      if number
        ["number", number]
      else
        matched = dictionary.select{|key, words| words.include?(word.downcase)}.keys

        if matched.length > 0
          [matched[0].to_s, word]
        else
          ['error', word]
        end
      end
    end
  end
end