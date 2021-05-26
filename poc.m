function cost = poc(individual)

      numberOfRows = size(individual, 1);
      numberOfCols = size(individual, 2);
  
      runningCost = 0;
  
      for i = 1:numberOfRows
          for j = 1:numberOfCols
              A = individual(i,j);

              if(A == 4)
                  runningCost = runningCost;
                  
              elseif(A == 5)
                  if(i == 1)
                      if(individual((i + 1),j) ~= 1)
                          runningCost = runningCost + 100;
                      else
                          runningCost = runningCost;
                      end
                  elseif(j == 1)
                      if(individual(i,(j + 1)) ~= 1)
                          runningCost = runningCost + 100;
                      else
                          runningCost = runningCost;
                      end
                  elseif(i == numberOfRows)
                      if(individual((i - 1),j) ~= 1)
                          runningCost = runningCost + 100;
                      else
                          runningCost = runningCost;
                      end
                  elseif(j == numberOfCols)
                      if(individual(i,(j - 1)) ~= 1)
                          runningCost = runningCost + 100;
                      else
                          runningCost = runningCost;
                      end
                  end
             
              else
                  
                  
                  north = [individual((i - 1),(j - 1)), individual((i - 1),j), individual((i - 1),(j + 1))];
                  south = [individual((i + 1),(j - 1)), individual((i + 1),j), individual((i + 1),(j + 1))];
                  west = [individual((i - 1),(j - 1)), individual(i,(j - 1)), individual((i + 1),(j - 1))];
                  east = [individual((i - 1),(j + 1)), individual(i,(j + 1)), individual((i + 1),(j + 1))];
                          
                  up = individual((i - 1),j);
                  topRight = individual((i - 1),(j + 1));
                  right = individual(i,(j + 1));
                  bottomRight = individual((i + 1),(j + 1));
                  down = individual((i + 1),j);
                  bottomLeft = individual((i + 1),(j - 1));
                  left = individual(i,(j - 1));
                  topLeft = individual((i - 1),(j - 1));
                  
                  northCost = topLeft + up + topRight;
                  eastCost = topRight + right + bottomRight;
                  southCost = bottomRight + down + bottomLeft;
                  westCost = bottomLeft + left + topLeft;
                  
                  acceptableValues = [1];
                  
                  firstResult = ismember(west, acceptableValues);
                  firstResultScore = sum(firstResult,'all');

                  secondResult = ismember(north, acceptableValues);
                  secondResultScore = sum(secondResult,'all');

                  thirdResult = ismember(east, acceptableValues);
                  thirdResultScore = sum(thirdResult,'all');
                            
                  fourthResult = ismember(south, acceptableValues);
                  fourthResultScore = sum(fourthResult,'all');
                  
                  total = firstResultScore + secondResultScore + thirdResultScore + fourthResultScore;

                           
                  switch A
                      case 1            
                          runningCost = runningCost;        
                      case 2
                          
                           if(total == 8)
                              if((northCost == 3 || eastCost == 3 || southCost == 3 || westCost == 3) ...
                                      && (northCost == 3 || eastCost == 3 || southCost == 3 || westCost == 3) ...
                                      && (northCost == 5 || eastCost == 5 || southCost == 5 || westCost == 5) ...
                                      && (northCost == 5 || eastCost == 5 || southCost == 5 || westCost == 5))
                                  runningCost = runningCost - 1;
                              else 
                                  runningCost = runningCost;
                               
                              end
                              
                           else 
                               runningCost = runningCost + 2;
                           end
        
                      otherwise
                          runningCost = runningCost;
                  end
              end
          end
      end
  
      room = sum(individual(:) == 2);
      corridor = sum(individual(:) == 1);
  
       
       %if(corridor/room > 10/4 && corridor/room < 17/4 )
        %  runningCost = runningCost + 50;
       %end

      cost = runningCost;

end

