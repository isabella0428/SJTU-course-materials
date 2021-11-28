
for i=1:6
    for j=1:6
        fprintf([num2str(reshape(cur_mark(i,j,:),1,[])*[1:6]','%1d'),'  ']);
    end
    fprintf('\n');
end
    
    