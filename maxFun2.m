function [k1 k2] = maxFun2(board, p)
%MAXFUN2 Function for making a Gomoku move.

% Opening game

% First move
if nnz(board) == 0
    k1 = 10;
    k2 = 10;
    return
elseif nnz(board) <= 2
    for i = 1:16
        for j = 1:16
            if board(i,j) ~= p && board(i,j) ~= 0
                if i <= 10 && board(i+1,j) == 0
                    k1 = i+1;
                    k2 = j;
                    return
                elseif i >= 11 && board(i-1,j) == 0
                    k1 = i-1;
                    k2 = j;
                    return
                end
            end
        end
    end
end

% Search for winning move
for i = 1:16
    for j = 1:16
        if board(i,j) == p
            if board(i+1,j) == p && board(i+2,j) == p && board(i+3,j) == p
                if i > 1 && board(i-1,j) == 0
                    k1 = i-1;
                    k2 = j;
                    return
                elseif i < 16 && board(i+4,j) == 0
                    k1 = i+4;
                    k2 = j;
                    return
                end
            elseif board(i,j+1) == p && board(i,j+2) == p && board(i,j+3) == p
                if j > 1 && board(i,j-1) == 0
                    k1 = i;
                    k2 = j-1;
                    return
                elseif j < 16 && board(i,j+4) == 0
                    k1 = i;
                    k2 = j+4;
                    return
                end
            elseif board(i+1,j+1) == p && board(i+2,j+2) == p && board(i+3,j+3) == p
                if i > 1 && j > 1 && board(i-1,j-1) == 0
                    k1 = i-1;
                    k2 = j-1;
                    return
                elseif i < 16 && j < 16 && board(i+4,j+4) == 0
                    k1 = i+4;
                    k2 = j+4;
                    return
                end
            end
        end
    end
end

% Search for opponent straight fours
for i = 1:16
    for j = 1:16
        if board(i,j) ~= p && board(i,j) ~= 0
            other = board(i,j);
            if board(i+1,j) == other && board(i+2,j) == other && board(i+3,j) == other
                if i > 1 && board(i-1,j) == 0
                    k1 = i-1;
                    k2 = j;
                    return
                elseif i < 16 && board(i+4,j) == 0
                    k1 = i+4;
                    k2 = j;
                    return
                end
            elseif board(i,j+1) == other && board(i,j+2) == other && board(i,j+3) == other
                if j > 1 && board(i,j-1) == 0
                    k1 = i;
                    k2 = j-1;
                    return
                elseif j < 16 && board(i,j+4) == 0
                    k1 = i;
                    k2 = j+4;
                    return
                end
            elseif board(i+1,j+1) == other && board(i+2,j+2) == other && board(i+3,j+3) == other
                if i > 1 && j > 1 && board(i-1,j-1) == 0
                    k1 = i-1;
                    k2 = j-1;
                    return
                elseif i < 16 && j < 16 && board(i+4,j+4) == 0
                    k1 = i+4;
                    k2 = j+4;
                    return
                end
            end
        end
    end
end

% Search for opponent open threes
for i = 2:16
    for j = 2:16
        if board(i, j) ~= 0 && board(i, j) ~= p
            other = board(i,j);
            if board(i-1, j) == 0 && board(i+1, j) == other && board(i+2, j) == other && board(i+3, j) == 0
                k1 = i-1;
                k2 = j;
                return
            end
            if board(i, j-1) == 0 && board(i, j+1) == other && board(i, j+2) == other && board(i, j+3) == 0
                k1 = i;
                k2 = j-1;
                return
            end
            if board(i-1, j-1) == 0 && board(i+1, j+1) == other && board(i+2, j+2) == other && board(i+3, j+3) == 0
                k1 = i-1;
                k2 = j-1;
                return
            end
        end
    end
end

% Search threat space for best move
bestScore = 0;
for i=1:19
    for j=1:19
        if board(i,j) ~= 0
            continue
        end
        tmpBoard = board;
        tmpBoard(i,j) = p;
        score = evalBoard(tmpBoard,p);
        if score > bestScore;
            bestScore = score;
            k1 = i;
            k2 = j;
        end 
    end
end
if bestScore > 0
    return
end

% Place next to any other own stone
mveI = 0;
moves = zeros(2,1);
for i=1:19
    for j=1:19
        if board(i,j) == p
            if i > 1 && j > 1 && board(i-1,j-1) == 0
                k1 = i-1;
                k2 = j-1;
                mveI = mveI + 1;
                moves(:,mveI) = [k1 k2];
            end
            if i < 19 && j < 19 && board(i+1,j+1) == 0
                k1 = i+1;
                k2 = j+1;
                mveI = mveI + 1;
                moves(:,mveI) = [k1 k2];
            end
            if i > 1 && board(i-1,j) == 0
                k1 = i-1;
                k2 = j;
                mveI = mveI + 1;
                moves(:,mveI) = [k1 k2];
            end
            if j > 1 && board(i,j-1) == 0
                k1 = i;
                k2 = j-1;
                mveI = mveI + 1;
                moves(:,mveI) = [k1 k2];
            end
            if i < 19 && board(i+1,j) == 0
                k1 = i+1;
                k2 = j;
                mveI = mveI + 1;
                moves(:,mveI) = [k1 k2];
            end
            if j < 19 && board(i,j+1) == 0
                k1 = i;
                k2 = j+1;
                mveI = mveI + 1;
                moves(:,mveI) = [k1 k2];
            end
        end
    end
end
if mveI > 0
    ii = randi(mveI);
    k1 = moves(1,ii);
    k2 = moves(2,ii);
    return
end

% Place randomly
k1 = randi(19,1);
k2 = randi(19,1);

end