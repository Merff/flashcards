class SuperMemo

  def self.execute(review, original, answer, efactor, repeat, interval, quality)
    quality  = set_quality(answer, original)
    efactor  = set_efactor(efactor, quality)
    repeat   = quality < 3 ? 1 : repeat + 1
    interval = set_interval(review)
    review   = DateTime.now + 
      if repeat == 1
        1
      elsif repeat == 2
        6
      else
        interval*efactor
      end
    { 
     quality:  quality,
     efactor:  efactor, 
     repeat:   repeat, 
     interval: interval,
     review:   review
    }
  end

  def self.set_quality(answer, original)
    if answer.downcase == original.downcase
      4
    elsif DamerauLevenshtein.distance(answer.downcase, original.downcase) == 1
      3
    else
      2
    end
  end

  def self.set_efactor(efactor, quality)
    efactor + (0.1-(5-quality))*(0.08+(5-quality)*0.02)
    [1.3, efactor].max
  end

  def self.set_interval(review)
    review - DateTime.now
  end
end


             
    
  