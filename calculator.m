function cost = calculator(individual)

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
                  
                  surrounding = up + topRight + right + bottomRight + down ...
                      + bottomLeft + left + topLeft;
                           
                  switch A
                      case 1
                          
                            acceptableValues = [1, 4, 5];
                  
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
                            % it's classed as being perfectly placed as long as it does not sit at the center of
                            % a huge block of ones.
                            if(total == 12)
                                if(surrounding == 8)
                                    if((individual((i - 2),j) + individual((i + 2),j) > 2) ...
                                            || (individual(i,(j - 2)) + individual(i,(j + 2)) > 2))
                                        runningCost = runningCost - 20;
                                    else
                                        runningCost = runningCost;
                                    end
                                else
                                    runningCost = runningCost;
                                end
                            elseif(total == 7)
                                if((northCost == 9 || eastCost == 9 || southCost == 9 || westCost == 9) ...
                                        || (northCost == 6 || eastCost == 6 || southCost == 6 || westCost == 6))
                                   runningCost = runningCost; 
                                else 
                                   runningCost = runningCost + 4;
                                end
                            elseif(total == 8)
                                if((northCost == 7 || eastCost == 7 || southCost == 7 || westCost == 7) ...
                                || (northCost == 10 || eastCost == 10 || southCost == 10 || westCost == 10) ...
                                || (northCost == 5 || eastCost == 5 || southCost == 5 || westCost == 5) ...
                                || (northCost == 8 || eastCost == 8 || southCost == 8 || westCost == 8))
                                   if((up == 2 || up == 3) || (down == 2 || down == 3) || (left == 2 || left == 3) || (right == 2 || right == 3))
                                       runningCost = runningCost;
                                   else
                                       runningCost = runningCost + 2;
                                   end 
                                else 
                                    runningCost = runningCost + 8;
                                end 
                            elseif(total == 4)
                                if((up + topRight + right == 3) || ...
                                        (up + topLeft + left == 3) || ...
                                        (down + bottomRight + right == 3) || ...
                                        (down + bottomLeft + left == 3))
                                    runningCost = runningCost - 5;
                                else
                                    runningCost = runningCost + 2;
                                end
                            else
                                runningCost = runningCost + 16;
                            end                            
                      case 2
                          
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
                          % it's classed as being perfectly placed as long as it does not sit at the center of
                          % a huge block of ones.
                          if(total == 12)
                              if(surrounding == 16)
                                    runningCost = runningCost - 5;
                                else
                                    runningCost = runningCost;
                                end
                              
                              
                              runningCost = runningCost - 1;
                          elseif(total == 7)
                              if((northCost == 9 || eastCost == 9 || southCost == 9 || westCost == 9) ...
                                      || (northCost == 3 || eastCost == 3 || southCost == 3 || westCost == 3))
                                 runningCost = runningCost; 
                              else 
                                 runningCost = runningCost + 2;
                              end
                          elseif(total == 8)
                              if((northCost == 8 || eastCost == 8 || southCost == 8 || westCost == 8) ...
                              || (northCost == 10 || eastCost == 10 || southCost == 10 || westCost == 10) ...
                              || (northCost == 4 || eastCost == 4 || southCost == 4 || westCost == 4))
                                 if((up == 1 || up == 3) || (down == 1 || down == 3) || (left == 1 || left == 3) || (right == 1 || right == 3))
                                     runningCost = runningCost;
                                 else
                                     runningCost = runningCost + 2;
                                 end 
                              else 
                                  runningCost = runningCost + 4;
                              end 
                          elseif(total == 4)
                              if((up + topRight + right == 3) || ...
                                      (up + topLeft + left == 3) || ...
                                      (down + bottomRight + right == 3) || ...
                                      (down + bottomLeft + left == 3))
                                  runningCost = runningCost - 5;
                              else
                                  runningCost = runningCost + 2;
                              end
                          else
                              runningCost = runningCost + 8;
                          end  
                      case 3

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
      end
  
      entry = sum(individual(:) == 3);
      room = sum(individual(:) == 2);
      corridor = sum(individual(:) == 1);
  
       
       if(room/entry < 3.99 || room/entry > 5)
          runningCost = runningCost + 150;
       end
       
       if(entry/corridor < 1/3 || entry/corridor > 2/3)
          runningCost = runningCost + 150;
       end 
       
      

      cost = runningCost;

end


%{
if(surrounding == 8)
                              if((individual((i - 2),j) + individual((i + 2),j) > 2) ...
                                      || (individual(i,(j - 2)) + individual(i,(j + 2)) > 2))
                                  runningCost = runningCost;
                              else 
                                  runningCost = runningCost + 1;
                              end
                          elseif(surrounding == 20)
                              if(northCost == 15 || eastCost == 15 || ... 
                                      southCost == 15 || westCost == 15)
                                  runningCost = runningCost;
                              elseif(northCost == 3 || eastCost == 3 || ... 
                                      southCost == 3 || westCost == 3)
                                  runningCost = runningCost + 4;
                              else
                                  runningCost = runningCost + 8;
                              end
                          elseif()
                              
                          
                             
                          else 
                              runningCost = runningCost + 16;  
                          end

%}

