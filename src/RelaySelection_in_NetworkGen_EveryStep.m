function [succdelPack1,unsucc1,averagepacketTX] = RelaySelection_in_NetworkGen_EveryStep(nodes,SDdist,maxretry,selection)
    succdelPack =0;
    averagepacketTX=[];
    unsucc=0;
    succdelPack1=[];
    unsucc1=[];
    retry=0;
    SRprop=0;
    RDprop=0;
    count=0;
   
    currentrange=100;


    for nodes1=1:length(nodes)
        
        currentnode = nodes(nodes1);
        

            %generate network ve find link poss for each node pair given the
            %dist.

               SDpossibility = 1-(SDdist/currentrange);  %currentposs Sd distance a göre mapping edilecek burasý ilk durumda relay selectiondan sonra
                                                              %relay selectionda poss. 1 olarak yapýyoruz cünkü relay fixleniyor pozisyon fix
                                                              %2.
                                                              %senaryoda
                                                              %whileiçinegiriyor
                succduration=0;
                % relay seçme - Sr - Rd distance return edilebilir ve random ve
                % diger 3 method ile seçim yapýp distancelarý proba map
                % edilecek belli bir fonksiyona göre örn: linear,expo
                %input olarak posab yerine distance alýnacak ona göre
                %posobiability hesaplanýcak (SD distance) --> possibility
                 %distance karesi ile ters orantýlý link outage rayleigh en kötü 0.01 en iyi 0.99 mapping exponent. ve linear (parabolik)

                retry=0;
                timeslot=0;
                
                

                while timeslot <= 1000
                    
                        flag = 1;
                        [SRprop,RDprop]=NetworkGen(currentnode,currentrange,selection);
                        if(SRprop == 0)
                            flag = 1;
                        else
                            flag = 0;
                        end

                        posscheckSD=rand(1); % rand # for poss. 
                        posscheckSR=rand(1);
                        posscheckRD=rand(1);
                        if(flag==0)
                            if(posscheckSD <= SDpossibility) % checking. dist and poss. 
                                  succdelPack=succdelPack + 1;                         
                                  succduration=succduration + 2 + (retry*4);
                                  timeslot=timeslot + 2;
                                  retry = 0;
                            else
                                  if(posscheckSR <= SRprop && posscheckRD <= RDprop)

                                      timeslot=timeslot + 4;
                                      succdelPack=succdelPack + 1;
                                      succduration=succduration + 4 + (retry*4);
                                      retry = 0;
                                  elseif ( posscheckSR <= SRprop && posscheckRD > RDprop)
                                        timeslot=timeslot+4;
                                        if(retry==maxretry)
                                           unsucc=unsucc+1;
                                           retry=0;
                                        else
                                           retry=retry+1; 
                                        end
                                  elseif (posscheckSR > SRprop && posscheckRD <= RDprop)
                                      timeslot=timeslot+4;
                                        if(retry==maxretry)
                                           unsucc=unsucc+1;
                                           retry=0;
                                        else
                                           retry=retry+1; 
                                        end
                                  else
                                        timeslot=timeslot+4;
                                        if(retry==maxretry)
                                           unsucc=unsucc+1;
                                           retry=0;
                                        else
                                           retry=retry+1; 
                                        end
                                  end

                            end
                        else
                            
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
                end

                averagepacketTX(nodes1) = (succduration) / (succdelPack);
                succdelPack1(nodes1) = succdelPack;
                unsucc1(nodes1) = unsucc;
                succdelPack=0;
                unsucc=0;
                
    end

end
    