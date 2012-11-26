format long
[n,m]=size(optimresults.x)
f1=min(optimresults.fval(:,1))
f2=min(optimresults.fval(:,2))
for i=1:n
    d(i)=sqrt((optimresults.fval(i,1)-f1)^2+(optimresults.fval(i,2)-f2)^2)
end
[mind,imind]=min(d)
bestx=optimresults.x(imind,:)
%1.0e+003 *7.903459774544590   0.001795507933490
  
     

