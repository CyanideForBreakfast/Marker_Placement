% will accept tif-file, array of markers, range, threshold and return array
% of markers
function [newMarkerList] = combination_Removal(tifFilename, markerPositions, range, threshold)
    [totalMarkers,two] = size(markerPositions);
    for i=1:totalMarkers
        res = testCombination(tifFilename, markerPositions, range, threshold, [], 1, totalMarkers, i);
        if(res.value==true)
            newMarkerList = res.list;
            break;
        end
    end
end

function res = testCombination(tifFilename, markerPositions, range, threshold, list, startIndex, totalMarkers, markersAllowed)
    res.value=false;
    %res.list = [];
    if(markersAllowed==1)
        for index = startIndex: totalMarkers
            coverage = calcCoverage(tifFilename, [list;markerPositions(index,1),markerPositions(index,2)], range);
            if(coverage>=threshold)
                res.value=true;
                res.list = [list;markerPositions(index,1),markerPositions(index,2)];
                break;
            end
        end
    else
        for index = startIndex:totalMarkers
            temp = testCombination(tifFilename, markerPositions, range, threshold, [list;markerPositions(index,1),markerPositions(index,2)], index+1, totalMarkers, markersAllowed-1);
            if(temp.value==true)
                res.value=true;
                res.list=temp.list;
                break;
            end
        end
    end
end