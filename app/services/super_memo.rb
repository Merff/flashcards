class SuperMemo

  def self.execute(original, answer, efactor, repeat, interval, quality)
    quality = set_quality(answer, original)
    efactor = set_efactor(efactor, quality)
    repeat  = quality < 3 ? 1 : repeat + 1
    interval = set_interval(repeat, interval)
    { 
     quality: quality,
     efactor: efactor, 
     repeat: repeat, 
     interval: interval
    }
  end

  def self.set_quality(answer, original)
    quality = if answer.downcase == original.downcase
      4
    elsif DamerauLevenshtein.distance(answer.downcase, original.downcase) == 1
      3
    else
      2
    end
  end

  def self.set_efactor(efactor, quality)
    efactor = efactor + (0.1-(5-quality))*(0.08+(5-quality)*0.02)
    efactor = [1.3, efactor].max
  end

  def self.set_interval(repeat, interval)
    interval = DateTime.now - interval
  end
end


             
    
  