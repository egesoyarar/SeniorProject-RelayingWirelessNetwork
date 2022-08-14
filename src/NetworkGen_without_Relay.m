% SOURCE - DESTINATION
% 1000
% Retry 4:8:500
function [succdelPack1,unsucc1,averagepacketTX] = NetworkGen_without_Relay(nodes,SDdist,maxretry)
succdelPack =0;
averagepacketTX=[];
unsucc=0;
succdelPack1=[];
unsucc1=[];
retry=0;
currentrange=100;

    for nodes1=1:length(nodes)
        
        SDpossibility = 1-(SDdist/currentrange);
        succduration = 0;
        timeslot = 0;
        retry = 0;
            while timeslot <= 1000
    %                     NLOC = zeros(2,2);
    %                     NLOC(1,1)=175;
    %                     NLOC(1,2)=200;
    %                     NLOC(2,1)=225;
    %                     NLOC(2,2)=200;                
                        posscheckSD = rand(1); % rand # for poss.                  
                        if(posscheckSD <= SDpossibility) % checking. dist and poss. 
                                  succdelPack=succdelPack + 1;                         
                                  succduration=succduration + 2 + (retry*2);
                                  timeslot=timeslot + 2;
                                  retry = 0;
                            else

                                  timeslot=timeslot+2;
                                  if(retry==maxretry)
                                     unsucc=unsucc+1;
                                     retry=0;
                                  else
                                     retry=retry+1; 
                                  end

                        end
                      
            end
            averagepacketTX(nodes1) = succduration / (succdelPack);
            succdelPack1(nodes1) = succdelPack;
            unsucc1(nodes1) = unsucc;
            succdelPack=0;
            unsucc=0;
            

    end
    
  
    
end
    