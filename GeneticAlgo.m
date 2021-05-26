clc;
clear;
close all;

%% Example problems defined

problem.roomCorridorTest.Width = 6;
problem.roomCorridorTest.Height = 10;
problem.roomCorridorTest.RowIntiorWallsPos = [];
problem.roomCorridorTest.ColIntiorWallsPos = [];
problem.roomCorridorTest.Cost = @calculator;

problem.poc.Width = 6;
problem.poc.Height = 9;
problem.poc.RowIntiorWallsPos = [];
problem.poc.ColIntiorWallsPos = [];
problem.poc.Cost = @poc;

problem.pocTwo.Width = 9;
problem.pocTwo.Height = 12;
problem.pocTwo.RowIntiorWallsPos = [];
problem.pocTwo.ColIntiorWallsPos = [];
problem.pocTwo.Cost = @poc;

problem.roomCorridorTestTwo.Width = 6;
problem.roomCorridorTestTwo.Height = 15;
problem.roomCorridorTestTwo.RowIntiorWallsPos = [];
problem.roomCorridorTestTwo.ColIntiorWallsPos = [];
problem.roomCorridorTestTwo.Cost = @calculator;

problem.roomCorridorTestThree.Width = 14;
problem.roomCorridorTestThree.Height = 10;
problem.roomCorridorTestThree.RowIntiorWallsPos = [];
problem.roomCorridorTestThree.ColIntiorWallsPos = [];
problem.roomCorridorTestThree.Cost = @calculator;

problem.roomEntryTest.Width = 5;
problem.roomEntryTest.Height = 5;
problem.roomEntryTest.RowIntiorWallsPos = [];
problem.roomEntryTest.ColIntiorWallsPos = [];
problem.roomEntryTest.Cost = @calculator;

problem.roomOne.Width = 26;
problem.roomOne.Height = 10;
problem.roomOne.RowIntiorWallsPos = [];
problem.roomOne.ColIntiorWallsPos = [];
problem.roomOne.Cost = @calculator;

problem.roomTwo.Width = 10;
problem.roomTwo.Height = 15;
problem.roomTwo.RowIntiorWallsPos = [];
problem.roomTwo.ColIntiorWallsPos = [];
problem.roomTwo.Cost = @calculator;


problem.roomThree.Width = 30;
problem.roomThree.Height = 10;
problem.roomThree.RowIntiorWallsPos = [2,3,4,5];
problem.roomThree.ColIntiorWallsPos = [25,26,27,28,29];
problem.roomThree.Cost = @calculator;

problem.roomFour.Width = 9;
problem.roomFour.Height = 13;
problem.roomFour.RowIntiorWallsPos = [2,3,4,5,9,10,11,12];
problem.roomFour.ColIntiorWallsPos = [5];
problem.roomFour.Cost = @calculator;


%% GA and parameters

parameters.population = 200;
parameters.iterations = 200;
parameters.crossoverPercentage = 1;
parameters.mutationRate = 0.15;

%problem.pocTwo

output = Output(problem.roomCorridorTestTwo, parameters);