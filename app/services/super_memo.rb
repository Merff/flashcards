class SuperMemo

  def self.apply(answer, original, efactor, repeat, interval)
    q = if answer.downcase == original.downcase
      4
    elsif DamerauLevenshtein.distance(answer.downcase, original.downcase) == 1
      3
    else
      2
    end
    $Q = q
    efactor_new = efactor + (0.1-(5-q))*(0.08+(5-q)*0.02)
    efactor_new = [1.3, efactor_new].max
    review = DateTime.now + if  repeat == 1
                           1
                          elsif repeat == 2
                           6
                          else
                           interval*efactor_new
                          end
    { 
     review: review,
     repeat: repeat + 1, 
     efactor: efactor_new, 
     interval: (review - DateTime.now)
    }
  end
end


             
    
  