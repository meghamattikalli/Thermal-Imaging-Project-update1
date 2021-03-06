function  stomach = measurestomach(a1,a2,l,height)

[X1,Y1,x1,y1]=mysmooth(a1);
[X2,Y2,x2,y2]=mysmooth(a2);
% blob analysis
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
C=step(blob,a1);
C2=step(blob,a2);
%
cll = centll(C,x1,y1); 
crl = centrl(C,x1,y1);
crl2 = centrl(C2,x2,y2);
%cll2 = centll(C2,x2,y2);
ymin2 = minloc(y2);
fstom=l(1,6);
bstom=l(2,6);
% pixel to physical ratio
t=height/(maxfun(Y2)-minfun(Y2));

if (abs(x2(fstom)-x2(bstom))<=3)
    bstom=0;
    track = ymin2:crl2;
    [~,sz]=size(track);
    disp(sz);
    valy = zeros(size(track));
    for n=1:sz
        valy(n)=y2(track(n));
    end

    leftval=y2(fstom);
    [~,szv]=size(valy);
    k = zeros(szv);
    for n=1:szv
        if valy(n)==leftval
            k(n)=n;
        elseif (valy(n)-1==leftval)||(valy(n)+1==leftval)
            k(n)=n;
%         elseif (valy(n)-2==leftval)||(valy(n)+2==leftval)
%             k(n)=n;    
        else
            k(n)=0;
        end
    end

    k=ridofzero(k);
    kloc=round(mean(k));
    projloc=track(kloc);
    bstom=projloc;
end

 a=sqrt((y1(cll)-y1(crl)).^2 + (x1(cll)-x1(crl)).^2);
 b=sqrt((y2(fstom)-y2(bstom)).^2 + (x2(fstom)-x2(bstom)).^2);
 stom= pi*(a+b)/2; %circumfrence of ellipse using Naive formula
 %stom1 = t*((stom/2));
 halfrect = (a+b); %perimeter of the half rectangle in (]
 stom2 = t*(stom); 
 stom3 = t*((stom/2)+halfrect);
 stom4 = t*((stom/2)+a); %half circumference + a ie, (| in (|]
 stom5 = (stom2+stom3+stom4)/3;
 %disp(stom5);

 p=sqrt((y1(cll)-y1(crl)).^2 + (x1(cll)-x1(crl)).^2)/2;
 q=sqrt((y2(fstom)-y2(bstom)).^2 + (x2(fstom)-x2(bstom)).^2)/2;
 stomm = pi*(3*(p+q)-sqrt((3*p+q)*(p+3*q))); %find circumference of the ellipse using Ramanujam formula
 %stomm1 = t*((stomm/2));
 halfrec = (p+q);
 stomm2 = t*(stomm); 
 stomm3 = t*((stomm/2)+halfrec);
 stomm4 = t*((stomm/2)+p); %changed here q to p
 stomm5 = (stomm2+stomm3+stomm4)/3;
 %disp(stomm5);
stomachx = (stom5+stomm5)/2;
stomach = stomachx + (2*stomachx/100);   %%applied 2% error correction
end
