range = 200;
markers =  [70,270; 170,80; 154,323; 116, 182];
tic
    [c,o] = calcCoverage("FloorWork.tif",markers, range)
timeElapsed = toc
%greedy_Removal("FloorWork.tif", [70,270; 170,80; 154,323; 116, 182; 200, 200], 200, 1)
% tic
%     combination_Removal("FloorWork.tif", markers, range, 1)
% timeElapsed = toc