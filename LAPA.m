% %Miranda Heredia 100996160
% %LAPA
% 
clear 
close all

iteration = 100;
nx = 10;
ny = 10;
v = zeros(nx,ny);
v(:,1) = 1; %Set Left BC to be 0
v_new = v;  %Hold V info to be updated
x_axis = [1 2 3 4 5 6 7 8 9 10];
y_axis = [1 2 3 4 5 6 7 8 9 10];
for i = 1:iteration
    for row = 1:ny
        for col = 2:nx-1
            if (row == 1)
                v_new(row,col) = v(row+1,col);
            elseif (row == ny)
                v_new(row,col) = v(row-1,col);
            else
                left = v(row,col-1);
                right = v(row,col+1);
                up = v(row-1,col);
                down = v(row+1,col); 
                v_new(row,col) = 0.25*sum([up down left right]);
            end
            
        end
    end
    v = v_new;
    figure(1);
    surf(x_axis,y_axis,v);
    pause(0.1)
end

%% Part 2 - Changing BCs E filed and Vector Field
iteration = 50;
nx = 10;
ny = 10;
v = zeros(nx,ny);
v(:,1) = 1; %left BC to 1
v(:,nx) = 1; %right BC to 1
% v(1,:) = 0;
% v(ny,:) = 0;
v_new = v;

for i = 1:iteration
    for row = 2:ny-1
        for col = 2:nx-1
            left = v(row,col-1);
            right = v(row,col+1);
            up = v(row-1,col);
            down = v(row+1,col); 
            v_new(row,col) = 0.25*sum([up down left right]);
        end
    end
    v = v_new;
    figure(2);
    surf(x_axis,y_axis,v_new);

    [X, Y] = gradient(v_new);
    figure(3);
    quiver(x_axis,y_axis,-X,-Y);
    pause(0.1);
end
%% Part 3 - ImBoxfilt
iteration = 50;
nx = 10;
ny = 10;
v = zeros(nx,ny);
v(:,1) = 1;
v(:,nx) = 1;
v_new = v;
x_axis = [1 2 3 4 5 6 7 8 9 10];
y_axis = [1 2 3 4 5 6 7 8 9 10];
for i = 1:iteration
    v_new = imboxfilt(v);
    v_new(:,1) = 1;
    v_new(:,nx) = 1;
    v_new(1,:) = 0;
    v_new(ny,:) = 0;
    figure(4);
    surf(x_axis,y_axis,v_new);
    hold on;
    zlim([0 1]);
    hold off;
    pause(0.1);
    v = v_new;
end
