range = 200;
markers =  [70,270; 170,80; 154,323; 116, 182; 100, 100; 120, 420; 60,300; 61,258];
tic
    [c,o] = calcCoverageOverlap("FloorWork.tif",markers, range)
timeElapsed = toc
%greedy_Removal("FloorWork.tif", [70,270; 170,80; 154,323; 116, 182; 200, 200], 200, 1)
tic
     list = combination_Removal("FloorWork.tif", markers, range, 1)
     [c1,o1] = calcCoverageOverlap("FloorWork.tif",list, range)
timeElapsed = toc