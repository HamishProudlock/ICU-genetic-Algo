function i = RouletteWheelSelection(p)

    r = rand*sum(p);
    c = cumsum(p);
    i = find(r <= c, 1, 'first');

end


%{
       c = [population.cost];
        avgc = mean(c);
        if avgc ~= 0
            c = c/avgc;
        end
        probab = exp(-1*c);
       RouletteWheelSelection(probab)
  %}