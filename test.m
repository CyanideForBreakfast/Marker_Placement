c = calcCoverage("FloorWork.tif", [70,270; 170,80; 154,323; 116, 182], 200);
greedy_Removal("FloorWork.tif", [70,270; 170,80; 154,323; 116, 182; 200, 200], 200, 1)
%combination_Removal("FloorWork.tif", [70,270; 170,80; 154,323; 116, 182; 200, 200], 200, 1)