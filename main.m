%clear board, cols, doDisplay, gameOver, j, k1, k2, moveFun, n, p, p2players, playerFun, players
clear all
close all
clc

doDisplay = 1;

players   = {'ALE','MAX','JOH'};
% playerFun = {@aleFun,@maxFun,@johFun}; % when we have all functions
playerFun = {@maxFun,@maxFun2,@johFun}; % for now all players use johFun

% randomize playing order
p2players = randperm(3);
% e.g., if p2players = [3 1 2], then 1=joh, 2=ale, 3=max in the loop below.

if doDisplay
    cols = {'b','r','g'};
    figure, hold on
    for j = 1:3, plot(10,10,['*' cols{j}]); end
    legend(strcat({'1 ','2 ','3 '},players(p2players)),'location','bestoutside');
    for j = 1:19, plot([1,19],[j,j],'k:'); end
    for j = 1:19, plot([j,j],[1,19],'k:'); end
end

board = zeros(19,19);
n = 0;
gameOver = false;
while ~gameOver && n < numel(board)
    for p = 1:3
        % new turn
        n = n + 1;
        
        % choose the right move function
        moveFun = playerFun{p2players(p)};
        
        % get the move (note that the output is linear index in 
        [k1 k2] = moveFun(board,p);
        
        % check that the move was legal
        assert(board(k1,k2) == 0);
        
        % update the board state
        board(k1,k2) = p;       
        
        % check to see if game over
        gameOver = isGameOver(board);
        
        % plot the board state
        if doDisplay
            plot(k1,k2,['o' cols{p}],'LineWidth',3)
            plot(k1,k2,['*' cols{p}],'LineWidth',3)
            if gameOver, title(sprintf('Player %d (%s) won!\n',p,players{p2players(p)})); end
            pause(0.5);
        end
    
        if gameOver, fprintf('Player %d won!\n',p); break; end
    end
end
