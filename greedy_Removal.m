function [reducedMarkerPositions] = greedy_Removal(tifFilename, markerPositions, range, threshold)
    [totalMarkers,two] = size(markerPositions);
    reducedMarkerPositions = markerPositions(:,:);
    while totalMarkers > 0
        markerToRemove = -1;
        maxCoverage = -1;
        for i=1:totalMarkers
            testMarkerPositions = reducedMarkerPositions(:,:);
            testMarkerPositions(i,:) = [];
            coverage = calcCoverage(tifFilename,testMarkerPositions,range);
            if(coverage>=maxCoverage)
                maxCoverage=coverage;
                markerToRemove = i;
            end
        end
        if(maxCoverage>=threshold)
            reducedMarkerPositions(markerToRemove,:) = [];
            [totalMarkers,two] = size(reducedMarkerPositions);
            continue;
            
        end
        break;
    end
end