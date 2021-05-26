function a = Mutation(x,rate)
  
  %number of variables in a population member
  variables = numel(x);
  %Determine how many points to mutate in a population member
  iterations = round(variables*rate);
  
  random = randperm(variables);
  
  %Mutate population member
  for point = 1:(iterations) 
      newNumber = randperm(2,1);      
      x(random(point)) = newNumber;
  end
   
  %Reposition walls
  x(:,1) = 4; 
  x(1,:) = 4; 
  x(end,:) = 4;
  x(:,end) = 4;
  
  x(7,1) = 5;
  x(8,1) = 5;  
  x(9,1) = 5;
  
  %{
  x(7,end) = 5;
  x(8,end) = 5;
  x(9,end) = 5;
  %}
  
  a = x;
  
end

