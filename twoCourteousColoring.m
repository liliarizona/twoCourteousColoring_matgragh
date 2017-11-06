function [set k]=twoCourteousColoring(A)
set=[];
fileID = fopen('twoCourteousColoringRecorder.txt','w');
%set graph g from Matrix A
graph_init;
g=graph;
set_matrix(g,A);

%set link list of g
numNode=nv(g);
elistG=[];
fprintf(fileID,'link list order:\n');
for i=1:1:numNode
    elistV=g(i);
    ni=length(elistV);
    for j=1:1:ni
        if elistV(j)>i
            elistG=[elistG; [i elistV(j)]];
            fprintf(fileID,'\t%d-%d',i,elistV(j));
        end
    end
end
fprintf(fileID,'\n');
%set vector w
numW=length(elistG);
wVector=zeros(1,numW);

whileFlag=1;
k=0;

tempG=graph;
while ((max(wVector)>=k || whileFlag)&& k<25)
    if whileFlag ~= 0
        whileFlag=0;
    end
    k=k+1;
    k
    fprintf(fileID,'k= %d\n',k);
    copy(tempG,g);
    
    tempWVector=ones(1,numW);
    %sort vector w[l]
    [sortedValueW indexTempW]=sort(wVector,'descend');
    for i=1:1:numW
        oneW=sortedValueW(i);
        oneEdge=elistG(indexTempW(i),:);
        %delete link
        delete(tempG,oneEdge(1),oneEdge(2));
        %check bridge
        bridgeTempG=bridges(tempG,'matrix');
        [mb nb]=size(bridgeTempG);
        if mb==0
            tempWVector(indexTempW(i))=0;
            fprintf(fileID,'\t deleted link: %d - %d\n',oneEdge(1),oneEdge(2));
        else
            add(tempG,oneEdge(1),oneEdge(2));
        end
    end
    wVector=wVector+tempWVector;
    set=[set;tempWVector];
    fprintf(fileID,'\t w Vector:')
    fprintf(fileID,'\t %d',wVector');
    fprintf(fileID,'\n');
end
free(tempG);
free(g);
fclose(fileID);