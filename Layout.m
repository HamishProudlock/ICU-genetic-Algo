function cost = Layout(individual)

  numberOfRows = size(individual, 1);
  numberOfCols = size(individual, 2);
  
  runningCost = 0;
  
  for i = 1:numberOfRows
      for j = 1:numberOfCols 
          A = individual(i,j);
          switch A
              case 1
                  
                  
                  % If a block is surrounded by all 1's or a combo of 1's 4's and 5's
                  % it's classed as being perfectly placed.
                  if(total == 12)
                      
                      up = individual((i - 1),j);
                      topRight = individual((i - 1),(j + 1));
                      right = individual(i,(j + 1));
                      bottomRight = individual((i + 1),(j + 1));
                      down = individual((i + 1),j);
                      bottomLeft = individual((i + 1),(j - 1));
                      left = individual(i,(j - 1));
                      topLeft = individual((i - 1),(j - 1));
                      
                      surrounding = up + topRight + right + bottomRight + down ...
                      + bottomLeft + left + topLeft;

                      if(surrounding == 8)
                          if((individual((i - 2),j) + individual((i + 2),j) > 2) ...
                                  || (individual(i,(j - 2)) + individual(i,(j + 2)) > 2))
                              runningCost = runningCost - 5;
                          else 
                              runningCost = runningCost + 4;
                          end
                      end
                  else
                      % A perfect block will have a score no less than 7 at
                      % least 5 1's need to surround a single 1.
                      if(total > 6)
                          % Ensures that all blocks around a 1 are grouped
                          % together with their own class of block.
                          if(firstResultScore < 2 || secondResultScore < 2 || thirdResultScore < 2 || fourthResultScore < 2)
                              %Checks if there is not a gap between 3's or
                              % 2's surrounding a 1
                              if(individual((i - 1),j) + individual((i + 1),j) + individual(i,(j - 1)) + individual(i,(j + 1)) ~= 4)
                                  runningCost = runningCost + 1;
                              else
                                  runningCost = runningCost + 2;
                              end
                          else
                              runningCost = runningCost + 8;
                          end
                      else
                          runningCost = runningCost + 16;
                      end
                  end

              case 2
                  
                  
                  north = [individual((i - 1),(j - 1)), individual((i - 1),j), individual((i - 1),(j + 1))];
                  south = [individual((i + 1),(j - 1)), individual((i + 1),j), individual((i + 1),(j + 1))];
                  west = [individual((i - 1),(j - 1)), individual(i,(j - 1)), individual((i + 1),(j - 1))];
                  east = [individual((i - 1),(j + 1)), individual(i,(j + 1)), individual((i + 1),(j + 1))];
                  
                  acceptableValues = [2, 4, 5];
                  
                  firstResult = ismember(west, acceptableValues);
                  firstResultScore = sum(firstResult,'all');
                  
                  secondResult = ismember(north, acceptableValues);
                  secondResultScore = sum(secondResult,'all');
                  
                  thirdResult = ismember(east, acceptableValues);
                  thirdResultScore = sum(thirdResult,'all');
                  
                  fourthResult = ismember(south, acceptableValues);
                  fourthResultScore = sum(fourthResult,'all');
                  
                  total = firstResultScore + secondResultScore + thirdResultScore + fourthResultScore;
                  
                  % If a block is surrounded by all 1's or a combo of 1's 4's and 5's
                  % it's classed as being perfectly placed.
                  if(total == 12)
                      runningCost = runningCost + 1;
                      
                  else
                      % A perfect block will have a score no less than 7 at
                      % least 5 1's need to surround a single 1.
                      if(total > 6)
                          % Ensures that all blocks around a 1 are grouped
                          % together with their own class of block.
                          if(firstResultScore < 2 || secondResultScore < 2 || thirdResultScore < 2 || fourthResultScore < 2)
                              %Checks if there is not a gap between 3's or
                              % 2's surrounding a 1
                              if(individual((i - 1),j) + individual((i + 1),j) + individual(i,(j - 1)) + individual(i,(j + 1)) ~= 4)
                                  runningCost = runningCost + 1;
                              else
                                  runningCost = runningCost + 2;
                              end
                          else
                              runningCost = runningCost + 8;
                          end
                      else
                          runningCost = runningCost + 16;
                      end
                  end
                  
                  
              case 3
                  north = [individual((i - 1),(j - 1)), individual((i - 1),j), individual((i - 1),(j + 1))];
                  south = [individual((i + 1),(j - 1)), individual((i + 1),j), individual((i + 1),(j + 1))];
                  west = [individual((i - 1),(j - 1)), individual(i,(j - 1)), individual((i + 1),(j - 1))];
                  east = [individual((i - 1),(j + 1)), individual(i,(j + 1)), individual((i + 1),(j + 1))];
                  
                  up = individual((i - 1),j);
                  down = individual((i + 1),j);
                  left = individual(i,(j - 1));
                  right = individual(i,(j + 1));
                  
                  acceptableValues = [3, 4, 5];
                  corridor = [1];
                  walls = [4];
                  OtherSpace = [1, 2];
                  
                  firstResult = ismember(west, acceptableValues);
                  firstResultScore = sum(firstResult,'all');
                  
                  secondResult = ismember(north, acceptableValues);
                  secondResultScore = sum(secondResult,'all');
                  
                  thirdResult = ismember(east, acceptableValues);
                  thirdResultScore = sum(thirdResult,'all');
                  
                  fourthResult = ismember(south, acceptableValues);
                  fourthResultScore = sum(fourthResult,'all');
                  
                  total = firstResultScore + secondResultScore + thirdResultScore + fourthResultScore;
                  
                  % An entry should only be connected to either one or two
                  % other entry blocks
                  if(total == 2)
                      % Entry blocks should never go round corners and
                      % should always be in a straight line
                      if((up == 3 && down == 3)||(left == 3 && right == 3))
                          % Checks to see if an entry block is wedged
                          % between a corridor and a room
                          if((up == 1 && down == 2 && left == 3 && right == 3) || (up == 2 && down == 1 && left == 3 && right == 3) ...
                                  || (up == 3 && down == 3 && left == 1 && right == 2) || (up == 3 && down == 3 && left == 2 && right == 1))
                              runningCost = runningCost - 5;
                          else
                              runningCost = runningCost + 2;
                          end
                      else
                          % If at least one entry block is positioned ok it
                          % is not peanilised as bad as if two were
                          % positioned badly
                          if(up == 3 || down == 3|| left == 3 || right == 3)
                              runningCost = runningCost + 2;
                          else 
                              runningCost = runningCost + 4;
                          end
                      end
                  else
                       % An entry should only be connected to either one or two
                       % other entry blocks 
                      if(total == 1)
                          
                          firstResultCorr = ismember(west, corridor);
                          firstResultScoreCorr = sum(firstResultCorr,'all');
                  
                          secondResultCorr = ismember(north, corridor);
                          secondResultScoreCorr = sum(secondResultCorr,'all');
                  
                          thirdResultCorr = ismember(east, corridor);
                          thirdResultScoreCorr = sum(thirdResultCorr,'all');
                  
                          fourthResultCorr = ismember(south, corridor);
                          fourthResultScoreCorr = sum(fourthResultCorr,'all');
                          
                          NW = firstResultScoreCorr + secondResultScoreCorr == 6;
                          SW = firstResultScoreCorr + fourthResultScoreCorr == 6;
                          NE = thirdResultScoreCorr + secondResultScoreCorr == 6;
                          SE = thirdResultScoreCorr + fourthResultScoreCorr == 6;
                          
                          if(NW || SW || NE || SE)
                              runningCost = runningCost;
                          else
                              runningCost = runningCost + 4;
                          end
                    
                      elseif(total == 6)
                          
                          firstResultWalls = ismember(west, walls);
                          firstResultScoreWalls = sum(firstResultWalls,'all');
                  
                          secondResultWalls = ismember(north, walls);
                          secondResultScoreWalls = sum(secondResultWalls,'all');
                  
                          thirdResultWalls = ismember(east, walls);
                          thirdResultScoreWalls = sum(thirdResultWalls,'all');
                  
                          fourthResultWalls = ismember(south, walls);
                          fourthResultScoreWalls = sum(fourthResultWalls,'all');
                          
                          if(firstResultScoreWalls == 3 || secondResultScoreWalls == 3 || thirdResultScoreWalls == 3 || fourthResultScoreWalls == 3)
                              if(up == 3 || down == 3||left == 3 || right == 3)
                                  
                                  firstResultOther = ismember(west, OtherSpace);
                                  firstResultScoreOther = sum(firstResultOther,'all');
                  
                                  secondResultOther = ismember(north, OtherSpace);
                                  secondResultScoreOther = sum(secondResultOther,'all');
                  
                                  thirdResultOther = ismember(east, OtherSpace);
                                  thirdResultScoreOther = sum(thirdResultOther,'all');
                  
                                  fourthResultOther = ismember(south, OtherSpace);
                                  fourthResultScoreOther = sum(fourthResultOther,'all');
                                  
                                  
                                  if(firstResultScoreOther == 3 || secondResultScoreOther == 3 || thirdResultScoreOther == 3 || fourthResultScoreOther == 3)
                                      runningCost = runningCost + 4;
                                  else
                                      runningCost = runningCost;
                                  end                                
                              else
                                  runningCost = runningCost + 4;
                              end
                          end
                      else
                          runningCost = runningCost + 8;
                      end
                  end
                  
              otherwise
                  runningCost = runningCost;
          end      
      end
  end
  
  a = sum(individual(:) == 3);
  b = sum(individual(:) == 2);
  c = sum(individual(:) == 1);
  
  if(a + b ~= 16)
      runningCost = runningCost + 50;
      
  end
  
  if(c ~= 12)
      runningCost = runningCost + 50;
  end
  

  
  cost = runningCost;
  
end

%{
if(sum(firstResult,'all') == 3)
                     if(sum(secondResult,'all') > 1)
                        if()
                        
                        else
                        end    
                     else
                         
                         
                     end
                  else          
                     if(sum(secondResult,'all') > 1)
                        if(sum(thirdResult,'all') == 3)
                            if(sum(fourthResult,'all') > 1)
                                runningCost = runningCost + 1;
                            else
                                runningCost = runningCost + 2;
                            end                       
                        else
                            
                           isWallThree = ismember(east, walls);
                           isWallFour = ismember(south, walls);
                           
                           if(sum(isWallOne,'all') == 3 || sum(isWallTwo,'all') == 3)
                              
                           end
                            
                            
                            
                            
                           runningCost = runningCost + 4;
                        end
                     else
                         
                        isWallOne = ismember(west, walls);
                        isWallTwo = ismember(north, walls);
                    
                        if(sum(isWallOne,'all') == 3 || sum(isWallTwo,'all') == 3)
                           if(sum(thirdResult,'all') > 1 && sum(fourthResult,'all') > 1)
                              runningCost = runningCost + 1;
                           else
                              runningCost = runningCost + 4; 
                           end
                        else 
                           runningCost = runningCost + 8;
                        end   
                     end   
                  end

population(i).Position(2,:) = 2;
      population(i).Position(3,:) = 2;
      population(i).Position(4,:) = 2;
      population(i).Position(5,:) = 2;
      population(i).Position(6,:) = 2;
      
      population(i).Position(7,:) = 3;
      population(i).Position(8,:) = 1;
      population(i).Position(9,:) = 1;
      population(i).Position(10,:) = 1;

 if(i > 5)
                                  if(left == 3 && right == 3)
                                      if(individual((i - 1),j) == 2 && ... 
                                              individual((i - 2),j) == 2 && ...
                                              individual((i - 3),j) == 2 && ...
                                              individual((i - 4),j) == 2 && ...
                                              individual((i - 5),j) == 2 && ...
                                              individual((i + 1),j) == 1 && ...
                                              individual((i + 2),j) == 1 && ...
                                              individual((i + 3),j) == 1)
                                          runningCost = runningCost;
                                      
                                      elseif(individual((i + 1),j) == 2 && ... 
                                              individual((i + 2),j) == 2 && ...
                                              individual((i + 3),j) == 2 && ...
                                              individual((i + 4),j) == 2 && ...
                                              individual((i + 5),j) == 2 && ...
                                              individual((i - 1),j) == 1 && ...
                                              individual((i - 2),j) == 1 && ...
                                              individual((i - 3),j) == 1)
                                          runningCost = runningCost;
                                      else
                                          runningCost = runningCost + 1;
                                      end
                                  else 
                                      if(individual((i - 1),j) == 2 && ... 
                                              individual((i - 2),j) == 2 && ...
                                              individual((i - 5),j) == 2)
                                          runningCost = runningCost;
                                      else
                                          runningCost = runningCost + 1;
                                      end
                                  end
                              
                                  
                              else
                                  
                                  
                              end
                              
                              
                              
                              
                          else
                              runningCost = runningCost + 1;
                          end













if(left == 3 && right == 3)
                                  if(i > 4 && up == 1 && numberOfRows - i > 4)
                                      if(individual((i + 1),j) == 2 && ... 
                                              individual((i + 2),j) == 2 && ...
                                              individual((i + 3),j) == 2 && ...
                                              individual((i + 4),j) == 2 && ...
                                              individual((i + 5),j) == 2)
                                          runningCost = runningCost - 5;
                                      else
                                          runningCost = runningCost + 1;
                                      end                                  
                                  elseif(i > 5 && down == 1 && numberOfRows - i > 3)
                                      if(individual((i - 1),j) == 2 && ... 
                                              individual((i - 2),j) == 2 && ...
                                              individual((i - 3),j) == 2 && ...
                                              individual((i - 4),j) == 2 && ...
                                              individual((i - 5),j) == 2)
                                          runningCost = runningCost - 5;
                                      else
                                          runningCost = runningCost + 1;
                                      end  
                                  else
                                      runningCost = runningCost + 2;
                                  end    
                              else
                                  if(j > 4 && left == 1 && numberOfCols - i > 4)
                                      if(individual(i,(j + 1)) == 2 && ... 
                                              individual(i,(j + 2)) == 2 && ...
                                              individual(i,(j + 3)) == 2 && ...
                                              individual(i,(j + 4)) == 2 && ...
                                              individual(i,(j + 5)) == 2)
                                          runningCost = runningCost - 5;
                                      else
                                          runningCost = runningCost + 1;
                                      end                                  
                                  elseif(j > 5 && right == 1 && numberOfCols - i > 3)
                                      if(individual(i,(j - 1)) == 2 && ... 
                                              individual(i,(j - 2)) == 2 && ...
                                              individual(i,(j - 3)) == 2 && ...
                                              individual(i,(j - 4)) == 2 && ...
                                              individual(i,(j - 5)) == 2)
                                          runningCost = runningCost - 5;
                                      else
                                          runningCost = runningCost + 1;
                                      end  
                                  else
                                      runningCost = runningCost + 2;
                                  end          
%}



