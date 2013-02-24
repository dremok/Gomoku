wins = zeros(3,1);
for gameNbr = 1:20
    main;
    wins(p2players(p)) = wins(p2players(p)) + 1;
end

wins