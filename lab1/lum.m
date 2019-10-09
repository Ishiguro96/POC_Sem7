function y=lum(obraz, k)
y=obraz;
for i=2:size(obraz)-1
    for j=2:size(obraz)-1
        m = sort([obraz(i-1,j-1), obraz(i,j-1), obraz(i+1,j-1), obraz(i-1,j), obraz(i,j), obraz(i+1,j), obraz(i-1,j+1), obraz(i,j+1), obraz(i+1,j+1)]);
        if(k~=0)
            m = m(k+1:9-k);
            m = [min(m), obraz(i,j), max(m)];
        end
        y(i,j)=median(m);
    end
end