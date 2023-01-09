%clear everything
clearvars;
close all;

%nice rules to try:
%50, 90, 110
regel = 90;      % Rule Number (8 bit)
raum = 1000;         % Size of the room (matrix)
zeit = 1000;             % time/iterations (heigth of the matrix)

%call the function and save the generatet matrix
y = wolfram_fun(regel,raum,zeit);

%display the matrix
figure()
imagesc(y)