close all
clear
maxretry = 500;
SDdist = 95;
nodes = 5:10:100;

averagepacketTX1tot = 0;
averagepacketTX2tot = 0;
averagepacketTX3tot = 0;
averagepacketTX4tot = 0;
averagepacketTX5tot = 0;

unsucc1tot = 0;
unsucc2tot = 0;
unsucc3tot = 0;
unsucc4tot = 0;
unsucc5tot = 0;

for testNum = 1:70
    [succdelPack1,unsucc1,averagepacketTX1] = RelaySelection_in_NetworkGen_EveryStep(nodes,SDdist,maxretry,1); % Selection, 1, DistanceMin method
    [succdelPack2,unsucc2,averagepacketTX2] = RelaySelection_in_NetworkGen_EveryStep(nodes,SDdist,maxretry,2); % Selection, 2, BlockedNodes method
    [succdelPack3,unsucc3,averagepacketTX3] = RelaySelection_in_NetworkGen_EveryStep(nodes,SDdist,maxretry,3); % Selection, 3, RandomSel method
    [succdelPack4,unsucc4,averagepacketTX4] = RelaySelection_in_NetworkGen_EveryStep(nodes,SDdist,maxretry,4); % Selection, 4, Area Min method
    [succdelPack5,unsucc5,averagepacketTX5] = NetworkGen_without_Relay(nodes,SDdist,maxretry); % No Relay
    
    unsucc1tot = unsucc1tot + unsucc1;
    unsucc2tot = unsucc2tot + unsucc2;
    unsucc3tot = unsucc3tot + unsucc3;
    unsucc4tot = unsucc4tot + unsucc4;
    unsucc5tot = unsucc5tot + unsucc5;
    
    averagepacketTX1tot = averagepacketTX1tot + averagepacketTX1;
    averagepacketTX2tot = averagepacketTX2tot + averagepacketTX2;
    averagepacketTX3tot = averagepacketTX3tot + averagepacketTX3;
    averagepacketTX4tot = averagepacketTX4tot + averagepacketTX4;
    averagepacketTX5tot = averagepacketTX5tot + averagepacketTX5;
    
end

averagepacketTX1tot = averagepacketTX1tot/testNum;
averagepacketTX2tot = averagepacketTX2tot/testNum;
averagepacketTX3tot = averagepacketTX3tot/testNum;
averagepacketTX4tot = averagepacketTX4tot/testNum;
averagepacketTX5tot = averagepacketTX5tot/testNum;

unsucc1tot = unsucc1tot/testNum;
unsucc2tot = unsucc2tot/testNum;
unsucc3tot = unsucc3tot/testNum;
unsucc4tot = unsucc4tot/testNum;
unsucc5tot = unsucc5tot/testNum;
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure(1);
% plot(nodes,succdelPack1,'b-o',nodes,succdelPack2,'c-*',nodes,succdelPack3,'g-.',nodes,succdelPack4,'r-+',nodes,succdelPack5,'m-x');
% 
% xlabel('Number of Nodes','fontsize',12);
% ylabel('Succesfull Packet Number','fontsize',12);
% legend('DistMin','Blocked Nodes','Randomly','Area Min','No Relay');
% title("Succesfull Packet Number vs Nodes with Max 4 Retry & 190m S-D dist & 200m Range");

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure(2);
%plot(nodes,unsucc1tot,'b-o',nodes,unsucc2tot,'c-*',nodes,unsucc3tot,'g-.',nodes,unsucc4tot,'r-+',nodes,unsucc5tot,'m-x');

xlabel('Number of Nodes','fontsize',12);
ylabel('Unsuccesfull Packet Number','fontsize',12);
legend('LinkAware1','NetworkAware','Random','LinkAware2','No Relay');
title("Unsuccesfull Packet, Max 8 Retry & 95m S-D dist & 100m Range");

%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3);
plot(nodes,averagepacketTX1tot,'b-o',nodes,averagepacketTX2tot,'c-*',nodes,averagepacketTX3tot,'g-.',nodes,averagepacketTX4tot,'r-+',nodes,averagepacketTX5tot,'m-x');

xlabel('Number of Nodes','fontsize',12);
ylabel('AveragepacketTX','fontsize',12);
legend('LinkAware1','NetworkAware','Random','LinkAware2','No Relay');
title("Duration,Max Unlimited Retry & 95m S-D dist & 100m Range");
