function score = evalBoard(board,p)
%EVAL Evaluation function for the three player Gomoku board

K_MAX = 10000;
K_OPEN_THREE = 1000;
K_CLOSED_FOUR = 900;

score = 0;

% Search windows of 5
i = 1;          % Horisontal n' vertical
while i <= 15
    j = 1;
    while j <= 19
        if isequal(board(j,i:i+4), ones(1,5)*p)
            score = score + K_MAX;
        end
        if isequal(board(i:i+4,j), ones(5,1)*p)
            score = score + K_MAX;
        end
        if board(j,i) == 0 && isequal(board(j,i+1:i+3), ones(1,3)*p) && board(j,i+4) == 0
            score = score + K_OPEN_THREE;
        end
        if board(i,j) == 0 && isequal(board(i+1:i+3,j), ones(3,1)*p) && board(i+4,j) == 0
            score = score + K_OPEN_THREE;
        end
        j = j+1;
    end
    i = i+1;
end
i = 1;          % Diagonal
while i <= 15
    j = 1;
    while j <= 15
        if board(i,j) == p && board(i+1,j+1) == p && board(i+2,j+2) == p && board(i+3,j+3) == p && board(i+4,j+4) == p
            score = score + K_MAX;
        end
        if board(j,i) == 0 && board(j+1,i+1) == p && board(j+2,i+2) == p && board(j+3,i+3) == p && board(j+4,i+4) == 0
            score = score + K_OPEN_THREE;
        end
        j = j+1;
    end
    i = i+1;
end
i = 1;
while i <= 15
    j = 5;
    while j <= 19
        if board(i,j) == p && board(i+1,j-1) == p && board(i+2,j-2) == p && board(i+3,j-3) == p && board(i+4,j-4) == p
            score = score + K_MAX;
        end
        if board(i,j) == 0 && board(i+1,j-1) == p && board(i+2,j-2) == p && board(i+3,j-3) == p && board(i+4,j-4) == 0
            score = score + K_OPEN_THREE;
        end
        j = j+1;
    end
    i = i+1;
end

% Search windows of 6
i = 1;          % Horisontal n' vertical
while i <= 14
    j = 1;
    while j <= 19
        if board(j,i) == 0 && isequal(board(j,i+1:i+4), ones(1,4)*p) && board(j,i+5) == 0
            score = score + K_MAX;
        end
        if board(i,j) == 0 && isequal(board(i+1:i+4,j), ones(4,1)*p) && board(i+5,j) == 0
            score = score + K_MAX;
        end
        if isClosedFourHorVer(i,j) == 1
            score = score + K_CLOSED_FOUR;
        end
        j = j+1;
    end
    i = i+1;
end
i = 1;          % Diagonal
while i <= 14
    j = 1;
    while j <= 14
        if board(i,j) == 0 && board(i+1,j+1) == p && board(i+2,j+2) == p && board(i+3,j+3) == p && board(i+4,j+4) == p && board(i+5,j+5) == 0
            score = score + K_MAX;
        end
        if isClosedFourDiag1(i,j) == 1
            score = score + K_CLOSED_FOUR;
        end
        j = j+1;
    end
    i = i+1;
end
i = 1;
while i <= 14
    j = 6;
    while j <= 19
        if board(i,j) == 0 && board(i+1,j-1) == p && board(i+2,j-2) == p && board(i+3,j-3) == p && board(i+4,j-4) == p && board(i+5,j-5) == 0
            score = score + K_MAX;
        end
        if isClosedFourDiag2(i,j) == 1
            score = score + K_CLOSED_FOUR;
        end
        j = j+1;
    end
    i = i+1;
end

    function found = isClosedFourDiag1(i,j)
        found = 0;
        if board(i,j) ~= 0 && board(i,j) ~= p
            if board(i+1,j+1) == p && board(i+2,j+2) == p && board(i+3,j+3) == p && board(i+4,j+4) == p && board(i+5,j+5) == 0
                found = 1;
                return
            end
        end
        if board(i+5,j+5) ~= 0 && board(i+5,j+5) ~= p
            if board(i,j) == 0 && board(i+1,j+1) == p && board(i+2,j+2) == p && board(i+3,j+3) == p && board(i+4,j+4) == p
                found = 1;
                return
            end
        end
    end

    function found = isClosedFourDiag2(i,j)
        found = 0;
        if board(i,j) ~= 0 && board(i,j) ~= p
            if board(i+1,j-1) == p && board(i+2,j-2) == p && board(i+3,j-3) == p && board(i+4,j-4) == p && board(i+5,j-5) == 0
                found = 1;
                return
            end
        end
        if board(i+5,j-5) ~= 0 && board(i+5,j-5) ~= p
            if board(i,j) == 0 && board(i+1,j-1) == p && board(i+2,j-2) == p && board(i+3,j-3) == p && board(i+4,j-4) == p
                found = 1;
                return
            end
        end
    end

    function found = isClosedFourHorVer(i,j)
        found = 0;
        if board(i,j) ~= 0 && board(i,j) ~= p
            if isequal(board(i+1:i+4,j),ones(4,1)*p) && board(i+5,j) == 0
                found = 1;
                return
            end
        end
        if board(i+5,j) ~= 0 && board(i+5,j) ~= p
            if isequal(board(i:i+3,j),ones(4,1)*p) && board(i+4,j) == 0
                found = 1;
                return
            end
        end
        if board(i,j) ~= 0 && board(i,j) ~= p
            if isequal(board(j,i+1:i+4),ones(1,4)*p) && board(j,i+5) == 0
                found = 1;
                return
            end
        end
        if board(j,i+5) ~= 0 && board(j,i+5) ~= p
            if isequal(board(j,i:i+3),ones(1,4)*p) && board(j,i+4) == 0
                found = 1;
                return
            end
        end
    end

end