%ªÊÕº£¨m”Îm2
x = zeros(10,1);                                                               
for m = 1:10                                                                  
   x(m) = m.^2;                                                                 
end 
plot(1:m,x);
title('m versus m^2');xlabel('m');ylabel('m^2');