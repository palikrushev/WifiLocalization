function [ ] = fileWrite()

fileID = fopen('myfile.txt','w');
fprintf(fileID,'%d\n',10);

fclose(fileID);

end

