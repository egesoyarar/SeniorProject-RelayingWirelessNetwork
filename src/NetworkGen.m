function[SRprop,RDprop]=NetworkGen(currentnode,currentrange,selection)
% currentnode=20;
% currentrange=201;
    env=400;
    SRDistance=0;
    DRDistance=0;
    NLOC = zeros(currentnode,2);
    NLOC(:,1) = env*rand(1,currentnode); %saving x coor
    NLOC(:,2) = env*rand(1,currentnode); %saving y coor
    NLOC(1,1)=153;
    NLOC(1,2)=200;
    NLOC(2,1)=248;
    NLOC(2,2)=200; 
    DIST =zeros(currentnode,currentnode); % distance metric
    interval = 0.8/(currentrange-1);
    probability = [0.1:interval:0.9];
    indexofmin = 0;
    SRDRmin=0;

    s = [1];  % 1 stands for Source
    t = [2];  % 2 stands for Destination

        for i=1:currentnode   % for finding s value                    
            for j=i+1:currentnode    % for finding t value                          
                posscheck = rand(1); % rand # for poss.
                DIST(i,j)= sqrt((NLOC(i,1)- NLOC(j,1))^2 + (NLOC(i,2)- NLOC(j,2))^2);   %finding dist.
                DIST(i,j)=ceil(DIST(i,j));
                if(DIST(i,j) < currentrange)  

                    if (posscheck <= probability(abs(currentrange-DIST(i,j)))) % checking. dist and poss.                                
                    s(length(s)+ 1) = i;
                    t(length(t)+ 1) = j;     
                    end
                end
            end                        
        end

    G = graph(s,t);
    source = neighbors(G,1); % source neighbors
    destination = neighbors(G,2); % destination neighbors
    possnodes = intersect(source,destination); % intersection of s and d

    if length(possnodes) ~=0
        check = 1;
        
        if(selection==1) %DIST MIN METHOD
            
           for Distmin = 1: length(possnodes)
              minrelay=possnodes(Distmin);
              SRmin = sqrt((NLOC(1,1)- NLOC(minrelay,1))^2 + (NLOC(1,2)- NLOC(minrelay,2))^2);
              DRmin = sqrt((NLOC(2,1)- NLOC(minrelay,1))^2 + (NLOC(2,2)- NLOC(minrelay,2))^2);
              SRDRmin(Distmin) = abs(SRmin -  DRmin);

           end
           indexofmin = find(SRDRmin==min(SRDRmin));
           relay=possnodes(indexofmin(1));

        elseif(selection==2) %BLOCKED NODES MIN METHOD
            
           for possnodesblocked = 1: length(possnodes)
                Testrelay=possnodes(possnodesblocked);
                RelayBlocked = neighbors(G,Testrelay);
                SD = unique([source' destination']);
                SDR = unique([source' destination' RelayBlocked']);
                Blocked = setdiff(SDR,SD);

                BlockedNumbers(possnodesblocked) = length(Blocked);
           end

            indexofmin = find(BlockedNumbers==min(BlockedNumbers));
            relay=possnodes(indexofmin(1));
            
        elseif(selection==3)  %RANDOM METHOD        
            
            y = randi(1);
            relay = possnodes(y);
            
        elseif(selection==4)  %AREA MIN METHOD    
            
            for Distmin = 1: length(possnodes)
                  minrelay=possnodes(Distmin);
                  SRmin = sqrt((NLOC(1,1)- NLOC(minrelay,1))^2 + (NLOC(1,2)- NLOC(minrelay,2))^2);
                  DRmin = sqrt((NLOC(2,1)- NLOC(minrelay,1))^2 + (NLOC(2,2)- NLOC(minrelay,2))^2);
                  SRDRmin(Distmin) = abs(SRmin -  DRmin);

            end
            temp=400;
            if min(SRDRmin) <= 5
                for height=1:length(SRDRmin)
                   if  abs(NLOC(possnodes(height),2)-200) < temp 
                        temp = abs(NLOC(possnodes(height),2)-200);
                        relay=possnodes(height);
                   end
                end
            else
                 indexofmin = find(SRDRmin==min(SRDRmin));
                 randomrelay = randi(length(indexofmin));
                 relay=possnodes(indexofmin(randomrelay));
            end     
           
        end
        
        SRDistance = ceil(sqrt((NLOC(1,1)- NLOC(relay,1))^2 + (NLOC(1,2)- NLOC(relay,2))^2));
        DRDistance = ceil(sqrt((NLOC(2,1)- NLOC(relay,1))^2 + (NLOC(2,2)- NLOC(relay,2))^2));

        SRprop=probability(currentrange-SRDistance);
        RDprop=probability(currentrange-DRDistance);

    else 

        SRprop=0;
        RDprop=0;
    end
    
    
end