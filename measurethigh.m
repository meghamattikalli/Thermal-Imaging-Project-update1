function d=measurethigh(p1,p2)
a=sqrt((p1(4,1,1)-p1(4,2,1)).^2+(p1(4,1,2)-p1(4,2,2)).^2);
b=sqrt((p2(4,1,1)-p2(4,2,1)).^2+(p2(4,1,2)-p2(4,2,2)).^2);
d=pi*((a/2)+b)/2;
end