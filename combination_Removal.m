% will accept tif-file, array of markers, range, threshold and return array
% of markers
function [newMarkerList] = combination_Removal(tifFilename, markerPositions, range, threshold)
    [totalMarkers,two] = size(markerPositions);
    for i=1:totalMarkers
        [res,o] = testCombination(tifFilename, markerPositions, range, threshold, [], 1, totalMarkers, i);
        if(res.value==true)
            newMarkerList = res.list;
            break;
        end
    end
end

function [res,o] = testCombination(tifFilename, markerPositions, range, threshold, list, startIndex, totalMarkers, markersAllowed)
    res.value=false;
    maxOverlap = -1;
    %res.list = [];
    if(markersAllowed==1)
        for index = startIndex: totalMarkers
            [coverage,overlapPercent] = calcCoverageOverlap(tifFilename, [list;markerPositions(index,1),markerPositions(index,2)], range);
            if(coverage>=threshold)
                res.value=true;
                if(overlapPercent>maxOverlap) 
                    res.list = [list;markerPositions(index,1),markerPositions(index,2)];
                    maxOverlap = overlapPercent;
                end
            end
        end
    else
        for index = startIndex:totalMarkers
            [temp,tempO] = testCombination(tifFilename, markerPositions, range, threshold, [list;markerPositions(index,1),markerPositions(index,2)], index+1, totalMarkers, markersAllowed-1);
            if(temp.value==true)
                res.value=true;
                if(tempO>maxOverlap)
                    res.list=temp.list;
                    maxOverlap = tempO;
                end
            end
        end
    end
    o = maxOverlap;
end