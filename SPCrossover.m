function [childOne, childTwo] = SPCrossover(parentOne,parentTwo,roomHeight, roomWidth)

    %Following code executes single point crossover, this was chosen over 
    %Uniform crossover as to limit variation and it was ultimately found to
    %be much faster.
    
    %create a random matrix filled with values leading up to the size of
    %the matrix
    randomPoints = randi([1, (roomHeight * roomWidth) - 1]);
    
    %random point in the above matrix is chosen as the splitting point
    %between parents to create two children
    childOne = [parentOne(1: randomPoints) parentTwo(randomPoints+1: end)];
    childTwo = [parentTwo(1: randomPoints) parentOne(randomPoints+1: end)];
    
    %turn arrays back into matrices
    childOne = reshape(childOne,[roomHeight,roomWidth]);
    childTwo = reshape(childTwo,[roomHeight,roomWidth]);
    
end

