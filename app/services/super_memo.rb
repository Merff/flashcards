class SuperMemo

  def apply(efactor, repeat, interval)
    q = 4
    efactor_new = efactor + (0.1-(5-q))*(0.08+(5-q)*0.02)

    efactor_new = [1.3, efactor_new].max

    review = DateTime.now if    repeat == 0
                          elsif repeat == 1
                            + 1
                          elsif repeat = 2
                            + 6
                          else
                            + interval*efactor_new
                          end
    update_attributes(
                    review: review,
                    repeat: += 1, 
                    efactor: efactor_new, 
                    interval: (review - DateTime.now)
                    )
  end
end


             
    
  