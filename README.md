# circles
This program detects circles in an image and mark their edges.

It is done for a scientific programming course at KTH, and is implemented in MATLAB.

# Description

The aim of this project was to detect circles in an image and mark the edges in MATLAB. The 
circles in the images were coins of different sizes. 
The image was loaded into the workspace using the “imread” function, which resulted in a 3D 
matrix. 

For further processing of the image it is preferable to convert the image to a 2D matrix, i.e. a 
grayscale image. This was done by multiplying each dimension with a constant, eliminating the 
third dimension. 

The next step of this project was to use the Sobel Operator on the grayscale image. The Sobel 
Operator creates a new binary image using the grayscale image where all the changes in contrast 
are marked with ones, and where there is no change in contrast in the picture, there will be zeros. 
This results in a picture with all the coin edges marked with white and everything else is a black 
background, as can be seen in the plot titled “Sobel”. 

To achieve this, two masks, called F1 and F2, were convolved with the x- and y-direction of the 
image. Then the square root the two products resulted in a matrix requiring further processing. 
This matrix had larger values where the contrast changed. A new, binary matrix was constructed 
that had ones where the value was greater than a threshold, found by trial and error. All the 
values lesser than the threshold were put to zero. 

Upon receiving the binary picture after the Sobel Operation was done, Hough Transform were 
performed. Hough Transform is used to find shapes in images by voting.  

Firstly, a 3D Accumulator Matrix was created, which had three parameters, the circles x and y 
coordinates and the circles radii. Then the voting procedure was constructed using for-loops. For 
each pixel of the image, if the equation of a circle with a known radii is fulfilled in relation to a 
threshold, the coordinates for the circle in the accumulator are voted for, meaning increasing a 
specific index value in the accumulator by +1. Therefore the centers of the circles in the image 
are expected to have many more votes than other indexes. 

Secondly, a filter was constructed, which ignores all small values in the accumulator because 
they cannot correspond to a circle and are seen as a noise. 

Thirdly, by using the function “imregionalmax”, maximas in the accumulator are found and 
assign as coordinates. 

Finally, the coordinates are used to draw green circles over the original image. 

After all this is done, plotting the graphs is desirable to see the results, along with checking the 
time it takes to run the project. 

# How to run

Open the file "detector.m" and change the input to whatever picture you would like to test.

Some images are included here. The code works best for images: test_uniform16.jpg, test_uniform17.jpg, test_uniform4.jpg.
