% Main function.
function MainFunction

global a;
a = 1;
b = 2;

fprintf('MainFunction(): before subscope\n');
who

SubFunction;

fprintf('MainFunction(): after subscope\n');
who


% Sub function.
function SubFunction

c = 3;
d = 4;

fprintf('SubFunction(): after subscope\n');
who



