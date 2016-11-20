% Will work best for images: test_uniform16.jpg,test_uniform17.jpg,
% test_uniform4.jpg
clear all, close all, clc
tic
Image = imread('test_uniform16.jpg');
I_gray = 0.2989 * Image(:, :, 1) + 0.5870 * Image(:, :, 2) + 0.1140 * Image(:, :, 3);

%% Sobel Operator

F1 = [-1 0 1; -2 0 2; -1 0 1];
F2 = [-1 -2 -1; 0 0 0; 1 2 1];
Gx = zeros(size(I_gray));
Gy = zeros(size(I_gray));
for i=2:size(I_gray,1)-1
    for j=2:size(I_gray,2)-1
        Gx(i,j) = sum(sum(double(I_gray(i-1:i+1,j-1:j+1)).*F1));
        Gy(i,j) = sum(sum(double(I_gray(i-1:i+1,j-1:j+1)).*F2));
    end
end
G = sqrt(Gx.^2 + Gy.^2);
T = zeros(size(G));

for ii = 1:numel(G)
    if G(ii) > 180 % 0.3 * max
        T(ii) = 1;
    else
        T(ii) = 0;
    end
end

I_sobel = logical(T);
I_edge = edge(I_gray,'sobel');

%% Hough Transform

Accumulator = zeros(size(I_sobel,1),size(I_sobel,2),55);
[x,y] = find(I_sobel);
nRow = size(I_sobel,1);
nCol = size(I_sobel,2);
threshold = 0.1;

for xPixels = 1:nRow
    for yPixels = 1:nCol
        for radii = 50:55
            circle=find(abs((x-xPixels).^2 + (y-yPixels).^2 - radii.^2) < threshold);
            if ~isempty(circle)
                Accumulator(xPixels,yPixels,radii) = Accumulator(xPixels,yPixels,radii) + length(circle);
            end
        end
    end
end

filter=Accumulator>max(max(max(Accumulator)))*0.7; % 0.32
BW = imregionalmax(Accumulator.*filter);
[xmax,ymax,rmax] = ind2sub(size(BW),find(BW));

for i = 1:length(xmax)
    for alpha = 0:0.01:2*pi
        Image(round(xmax(i)+rmax(i)*cos(alpha)),round(ymax(i)+rmax(i)*sin(alpha)),2)=255;
        Image(round(xmax(i)+rmax(i)*cos(alpha)),round(ymax(i)+rmax(i)*sin(alpha)),[1,3])=0;
    end
end

%% Plotting

figure
subplot(1,3,1), imshow(I_sobel), title('Sobel')
subplot(1,3,2), imshow(I_edge), title('Edge')
subplot(1,3,3), imshow(I_gray), title('Grayscale')
hold on

figure
imshow(Image), title('Image')
hold on

toc
