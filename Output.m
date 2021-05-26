function output = GA(problemRoom, parameters)

  %Intialise
  roomWidth = problemRoom.Width;
  roomHeight = problemRoom.Height;
  roomRowIntiorWallsPos = problemRoom.RowIntiorWallsPos;
  roomColIntiorWallsPos = problemRoom.ColIntiorWallsPos;
  
  %Define basic GA elements
  highestCost = inf;
  currentBestSolution.cost = highestCost; 
  individual.chromo = [];
  population = repmat(individual, parameters.population, 1);
  numberOfChildren = parameters.population;
  
  %Asort intial population, designed to create a more cohesive and stable
  %starting population
  for i = 1:parameters.population
      population(i).Position = randi([1, 2], roomHeight, roomWidth);
      

      modulo = 1;
      
      for r = 1:roomHeight
          if(modulo == 2 || modulo == 1)
              p = randperm(2,1);
              a = p(1);
              population(i).Position(r:1) = a;
              modulo = modulo + 1;
          else
              if(mod(modulo,6) == 0 && population(i).Position(r - 1, 1) == 2)
                  population(i).Position(r,:) = 3;
                  modulo = modulo + 1;
              elseif(mod(modulo,5) == 0 && population(i).Position(r - 1, 1) == 1)
                  population(i).Position(r,:) = 3;
                  modulo = modulo + 1;
              else
                  above = population(i).Position(r - 1, 1);
                  twoAbove = population(i).Position(r - 2, 1);
                  if(above == 3 && twoAbove == 2)
                      population(i).Position(r,:) = 1;
                      modulo = modulo + 1;
                  elseif(above == 3 && twoAbove == 1)
                      population(i).Position(r,:) = 2;
                      modulo = modulo + 1;
                  elseif(above == 2) 
                      population(i).Position(r,:) = 2;
                      modulo = modulo + 1;
                  elseif(above == 1)
                      population(i).Position(r,:) = 1;
                      modulo = modulo + 1;
                  else 
                      modulo = modulo + 1;
                  end
                  if(mod(modulo,9) == 0)
                      p = randperm(2,1);
                      a = p(1);
                      population(i).Position(r:1) = a;
                      modulo = 3;
                  end
              end         
          end
      end
      
      
      %Define the position of walls and room entrances
      population(i).Position(:,1) = 4; 
      population(i).Position(1,:) = 4; 
      population(i).Position(end,:) = 4;
      population(i).Position(:,end) = 4;
      
      population(i).Position(7,1) = 5;
      population(i).Position(8,1) = 5;
      population(i).Position(9,1) = 5;
      
      %{
      population(i).Position(7,end) = 5;
      population(i).Position(8,end) = 5;
      population(i).Position(9,end) = 5;
      %}
      
      for r = 1:length(roomRowIntiorWallsPos)
          for c = 1:length(roomColIntiorWallsPos)
               population(i).Position(roomRowIntiorWallsPos(r),roomColIntiorWallsPos(c)) = 4;
          end
      end
      
      population(i).cost = problemRoom.Cost(population(i).Position);
      
      if (population(i).cost < currentBestSolution.cost)
          currentBestSolution = population(i);         
      end
      
  end
  
  % Main GA Loop - This section of code was written with help from the
  % reasource referenced as "resource one" on the readme file on GitLab
  
  %Array containing all the best solutions from each generation
  bestSolutions = zeros(parameters.iterations, 1);
  
  for iteration = 1:parameters.iterations

       %Array containing child population. Specifically it is an array of
       %with two different coloums, one for each child. 
       childPopulation = repmat(individual, numberOfChildren/2, 2);
       
       %Single Point Crossover
       for c = 1:(parameters.population/2)
         
           random = randperm(parameters.population);
           parentFirst = population(random(1));
           parentSecond = population(random(2));
           
           [childPopulation(c, 1).Position, childPopulation(c, 2).Position] = SPCrossover(parentFirst.Position, ...
               parentSecond.Position, roomHeight, roomWidth);
       end
       
       %Merge childrens
       childPopulation = childPopulation(:);
       
       %Mutation 
       for mutation = 1:parameters.population
           
           %Mutate child population
           mutant = Mutation(childPopulation(mutation).Position, parameters.mutationRate);
           childPopulation(mutation).Position = mutant;
           mutantCost = problemRoom.Cost(childPopulation(mutation).Position);
           childPopulation(mutation).cost = mutantCost;
           
           %If a mutant is better than the best solution update it.
           if (mutantCost < currentBestSolution.cost)
               currentBestSolution = childPopulation(mutation);         
           end
           
       end
       
       %Iterations best solution is added to list
       bestSolutions(iteration) = currentBestSolution.cost;
       
       %Merge parents and children into a single population
       population = [ population
                      childPopulation]
                  
       %Sort population based on score
       [sortedCostValues, sortOrder] = sort([population.cost]);
       population = population(sortOrder,:);
       
       %Find halfway point between children and parents
       halfway = numel(population)/2;
       
       %Cut population in half to return to set population size
       population = population(1: halfway); 
       
       %Print out the current iteration and the current best score.
       disp(['Currrent It: ' num2str(iteration) ': Current best cost: = ' num2str(bestSolutions(iteration))]);
      
  end
  
  %Output results
  output.currentBestSolution = currentBestSolution;
  output.population = population;

end

