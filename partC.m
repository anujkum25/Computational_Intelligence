
clear;
close;
clc;
%%% case -1 : n=3

% genereated polynomial

MaxIteration=10;
for iteration=1:MaxIteration
    % Generating random roots
    x1=randi([-10 10],1,1);
    x2=randi([-10 10],1,1);
    x3=randi([-10 10],1,1);
    
    % explaning the ploynomial
    syms x
    y=expand((x-x1)*(x-x2)*(x-x3));
    % extracting coefficients from polynomial
    c=sym2poly(y);
    
    % priniting the results
    fprintf('x1: %d x2: %d x3: %d  Iteration: %d ', x1, x2, x3,iteration);
    g=sprintf('%d ', c);
    fprintf(' Coefficients of polynomial: %s \n',g)
end
    

clear;
close;
clc;
%%% case -1 : n=4

% genereated polynomial

MaxIteration=10;
for iteration=1:MaxIteration
    x1=randi([-10 10],1,1);
    x2=randi([-10 10],1,1);
    x3=randi([-10 10],1,1);
    x4=randi([-10 10],1,1);

    
    syms x
    y=expand((x-x1)*(x-x2)*(x-x3)*(x-x4));
    c=sym2poly(y);
    fprintf('x1: %d x2: %d x3: %d x4: %d Iteration: %d ', x1, x2, x3,x4,iteration);
    g=sprintf('%d ', c);
    fprintf(' Coefficients of polynomial: %s \n',g)
end    


clear;
close;
clc;
%%% case -1 : n=5

% genereated polynomial

MaxIteration=10;
for iteration=1:MaxIteration
    x1=randi([-10 10],1,1);
    x2=randi([-10 10],1,1);
    x3=randi([-10 10],1,1);
    x4=randi([-10 10],1,1);
    x5=randi([-10 10],1,1);

    
    syms x
    y=expand((x-x1)*(x-x2)*(x-x3)*(x-x4)*(x-x5));
    c=sym2poly(y);
    fprintf('x1: %d x2: %d x3: %d x4: %d x5: %d Iteration: %d ', x1, x2, x3,x4,x5,iteration);
    g=sprintf('%d ', c);
    fprintf(' Coefficients of polynomial: %s \n',g)
end        
    

    


