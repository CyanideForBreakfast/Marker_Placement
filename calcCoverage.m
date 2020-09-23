x = imread("FloorWork.tif"); 
xd = im2double(rgb2gray(x));
a = xd;
[r,c] = size(a);


cameras = [100,270; 150,80; 60,200]; % list of cameras with coordinates
range = 110; % range of each camera

% making sure the image is purely black and white
bitmask = a<0.5;
res = a;
res(bitmask) = 0;
a = res;

bitmask = a>0.5;
res=a;
res(bitmask) = 1;

a=res;

[total_cameras, two] = size(cameras);
for l = 1:total_cameras
    def = [cameras(l,1), cameras(l,2)];
    for i = 1:r
        for j = 1:c
            pt = [i,j];
            if(i==def(1) && j==def(2))
                continue;
            end
            if(anyWallInBetween(a,pt,def)==false && a(pt(1),pt(2))==1 && inRange(pt,def,range))
                a(pt(1),pt(2)) = 0.5;
            end
        end
    end
end
% calculate percentage
totalWhites = 0;
totalGrey = 0;
totalBlack = 0;
for i=1:r
    for j=1:c
        if(a(i,j)==1) 
            totalWhites = totalWhites+1;
            continue;
        end
        if(a(i,j)==0.5)
            totalGrey = totalGrey+1;
        end
        if(a(i,j)==0)
            totalBlack = totalBlack+1;
        end
    end
end

fprintf("Coverage: %f\n",totalGrey/(totalWhites+totalGrey));

% shade square of the cameras
wid = 5;
colorno = 0.8;

for l = 1:total_cameras
    def = [cameras(l,1), cameras(l,2)];
    for i=-wid:wid
        for j=-wid:wid
            a(def(1)+i,def(2)+j) = colorno;
        end
    end
end

imshow(a);

%check if a pixel is in range
function t2f = inRange(pt1,pt2,range)
    dis = (pt1(1)-pt2(1))*(pt1(1)-pt2(1)) + (pt1(2)-pt2(2))*(pt1(2)-pt2(2));
    dis = sqrt(dis);
    t2f = false;
    if(dis<=range) 
        t2f = true;
    end
end

%check if pixel is blocked by a wall
function t2f = anyWallInBetween(arr,pt1,pt2)
t2f = false;
z = [abs(pt1(1)-pt2(1)),abs(pt1(2)-pt2(2))];
if(z(1)>=z(2))
    inc = (pt1(2)-pt2(2))/z(1);
    k = 1;
    if(pt1(1)-pt2(1)<0)
        k=-1;
    end
    for i = -k:k:pt1(1)-pt2(1)-k
        if(abs(fix(i+pt2(1)))==0 || abs(fix(i*inc*k+pt2(2)))==0)
            continue;
        end;
        if(arr(abs(fix(i+pt2(1))),abs(fix(i*inc*k+pt2(2))))==0)
            t2f = true;
        end
    end        
end
if(z(1)<z(2))
   inc = (pt1(1)-pt2(1))/z(2);
   k=1;
   if(pt1(2)-pt2(2)<0)
       k=-1;
   end
   for i = -k:k:pt1(2)-pt2(2)-k
       if(abs(fix(i*inc*k+pt2(1)))==0 || abs(fix(i+pt2(2)))==0)
           continue;
       end
        if(arr(abs(fix(i*inc*k+pt2(1))),abs(fix(i+pt2(2))))==0)
            t2f = true;
        end
   end
end
end