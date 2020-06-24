close all
clear all

%% Specify label suffix for saving figures
suffix = '_wout_hypothesized_6_18_2020';

%% Set simulation parameters
params{1,1} = .05; %dt Time units in seconds
params{2,1} =0; %t0
tmax=40; % in seconds Basic period should be about 5 sec.
params{3,1}=tmax; %tmax Basic period should be about 5 sec.
t=params{2,1}:params{1,1}:params{3,1};
nt=length(t); % number of time points
xlimits=[1 40]; % time range to show in plotting

params{4,1} = 1.75; %pmax maximum pressure grasper can exert on food (an arbitrary numb.)
params{5,1}= 1.0/sqrt(2); %tau_p time constant (in seconds) for pressure applied by grasper - orginial is 1.0
params{6,1} = 2.0/sqrt(2); %tau_pinch time constant (in seconds) for pressure of pinch - original is 2.0
params{7,1} = 0.5/sqrt(2); %tau_pull time constant (in seconds) for B8 pulling
params{8,1} = 1.0/sqrt(2); %tau_m time constant (in seconds) for I2 and I3 muscles
params{9,1} = 1.0; %tau_x time constant (in seconds) for grapser motion - original 1.0
params{10,1} = 1.0; %tau_y time constant (in seconds) for body motion
params{11,1} = 0.01; %prot_pas passive protractive force - original 0.01
params{12,1} = 0.015; %retr_pas passive retractive force - original 0.015
params{13,1} = 2.0; %buccalM_K spring constant representing boddy from buccal mass to ground
params{14,1} = 0.0; %buccalM_rest resting position of body
params{15,1} = 0.5; %F_pinch pinch force, original 0.15params{18,1} = 1.0; % in the animal this is ~10-15 mN
params{16,1} = 1; % force scaler
params{17,1} = 0.1; %gap influence of CBI2-CBI3 gap junction on a scale of 0 to 1.  Not used yet...
params{18,1} = 5000; %CBI3 refractory period duration in ms
params{19,1} = 3000; %B40B30 post activity B8 Excitation Duration (Duration based on Jing et al. 2004) in ms
params{20,1} = 1; %Maximum I3 force In this animal this is ~150-300 mN
params{21,1} = 1.5; %Maximum I2 force
params{22,1} = 0.2; %Maximum hinge force
params{23,1} = 0.1; %grasperSpring_K spring constant representing attachment between buccal mass and head
params{24,1} = 0.4; %grasperSpring_rest resting position of the buccal mass within the head
params{25,1} = 0.4; %mu_s coefficient of static friction at grasper
params{26,1} = 0.3; %mu_k coefficient of kinetic friction at grasper
params{27,1} = 0.3; %mu_s coefficient of static friction at jaws
params{28,1} = 0.3; %mu_k coefficient of kinetic friction at jaws


thresholds{1,1} = 0.75; %Prot_thresh threshold for having reached sufficient protraction - original 0.8
thresholds{2,1} = 0.4; %ret_thresh threshold for having reached sufficient retraction - original 0.4
thresholds{3,1} = 0.4; % 0.48 threshold for activing B38 when B20 is silent (retraction/ingestion)
thresholds{4,1} = 0.4; % threshold for activing B38 when B20 is active (protraction/egestion)
thresholds{5,1} = 0.89; %B64_thresh_retract_biting
thresholds{6,1} = 0.4; % 0.5 B64_thresh_retract_swallowing 
thresholds{7,1} = 0.5; %B64_thresh_retract_reject
thresholds{8,1} = 0.45; %B64_thresh_protract_biting
thresholds{9,1} = 0.45; %B64_thresh_protract_swallowing
thresholds{10,1} = 0.3; %B64_thresh_protract_reject
thresholds{11,1} = 0.7; %B4B5 threshold
thresholds{12,1} = 0.75; %B31/B32 threshold for protraction during swallowing
thresholds{13,1} = 0.4; %B31/B32 threshold for retraction during swallowing
thresholds{14,1} = 0.89; %B31/B32 threshold for protraction during rejection
thresholds{15,1} = 0.6; %B31/B32 threshold for retraction during rejection
thresholds{16,1} = 0.9; %B31/B32 threshold for protraction during biting
thresholds{17,1} = 0.55; %B31/B32 threshold for retraction during biting
thresholds{18,1} = 0.7; %B7_thresh_protract_reject threshold for protraction during rejection
thresholds{19,1} = 0.9; %B7_thresh_protract_biting threshold for protraction during biting
thresholds{20,1} = 0.25; %B6B9B3_pressure_thresh_swallowing
thresholds{21,1} = 0.2; %B6B9B3_pressure_thresh_biting
thresholds{22,1} = 0.75; %B6B9B3_pressure_thresh_reject



modulation{1,1} = 0.5;%I2_tau_ingestion;
modulation{2,1} = 1.4;%I2_tau_egestion;
    
seaweed_strength = 10;


% create stimulation pattern
stim=zeros(13,nt);

%% Biting
chemicalAtLips = ones(1,nt);
mechanicalAtLips = ones(1,nt);
mechanicalInGrasper = zeros(1,nt);
object_fixation = zeros(1,nt); % is the object fixed (1) or not fixed (0)
[bite_avec,bite_bvec,bite_cvec] = Aplysia_boolean_model_withfriction(chemicalAtLips,mechanicalAtLips,mechanicalInGrasper,params,thresholds,modulation,stim,seaweed_strength, object_fixation);

Plot_behavior(t,bite_avec,bite_bvec,bite_cvec,['Bite_' suffix],xlimits,params{4,1},params)

%% Swallowing
chemicalAtLips = ones(1,nt);
mechanicalAtLips = ones(1,nt);
mechanicalInGrasper = ones(1,nt);
object_fixation = ones(1,nt); % is the object fixed (1) or not fixed (0)
[swallow_avec,swallow_bvec,swallow_cvec] = Aplysia_boolean_model_withfriction(chemicalAtLips,mechanicalAtLips,mechanicalInGrasper,params,thresholds,modulation,stim,seaweed_strength, object_fixation);

Plot_behavior(t,swallow_avec,swallow_bvec,swallow_cvec,['Swallow_' suffix],xlimits,params{4,1},params)

%plot close up of grasper motion and force for swallowing
%Grasper Motion
figure
subplot(2,1,1)
set(gcf,'Color','white')
hold on
plot(t,(swallow_bvec(6,:)-swallow_bvec(8,:)),'b','LineWidth',2)
hold off
set(gca,'FontSize',16)
ylabel('Grasper Motion')
grid on
xlim([10 20])

%Force
subplot(2,1,2)
set(gcf,'Color','white')
hold on
plot(t,swallow_bvec(7,:),'k','LineWidth',2)
hold off
set(gca,'FontSize',16)
ylabel('Force')
grid on
xlim([10 20])

%% Rejection
chemicalAtLips = zeros(1,nt);
mechanicalAtLips = ones(1,nt);
mechanicalInGrasper = ones(1,nt);
object_fixation = zeros(1,nt); % is the object fixed (1) or not fixed (0)
[reject_avec,reject_bvec,reject_cvec] = Aplysia_boolean_model_withfriction(chemicalAtLips,mechanicalAtLips,mechanicalInGrasper,params,thresholds,modulation,stim,seaweed_strength, object_fixation);

Plot_behavior(t,reject_avec,reject_bvec,reject_cvec,['Reject_' suffix],xlimits,params{4,1},params)

%% Multifunctional swallowing of different strength seaweeds
seaweed_strength_min = 0.1;
seaweed_strength_max = 0.5;
step_size = 0.1;
num_strengths = round((seaweed_strength_max-seaweed_strength_min)/step_size+1);
i = 1;

object_fixation = ones(1,nt); % is the object fixed (1) or not fixed (0)
figure
set(gcf,'Color','white')
for seaweed_strength = seaweed_strength_min:step_size:seaweed_strength_max
    
    chemicalAtLips = ones(1,nt);
    mechanicalAtLips = ones(1,nt);
    mechanicalInGrasper = ones(1,nt);
    [swallow_avec2,swallow_bvec2,swallow_cvec2] = Aplysia_boolean_model_withfriction(chemicalAtLips,mechanicalAtLips,mechanicalInGrasper,params,thresholds,modulation,stim,seaweed_strength, object_fixation);
    
    seaweed_strength_result{i,:} = {seaweed_strength,swallow_avec2,swallow_bvec2,swallow_cvec2};
    
    subplot(num_strengths,1,i)
    plot(t,swallow_bvec2(7,:),'k','LineWidth',2)
    hold on
    plot(t,(swallow_bvec2(6,:)-swallow_bvec2(8,:)),'b','LineWidth',2)
    hold off
    if i==1
        legend({'Normalized Force on Transducer','Normalized Grasper Motion'},'Orientation','horizontal','Position',[0.337905404191644,0.941469018401128,0.350331117341061,0.027292575735973],'Box','off','FontSize',12)
    end
    set(gca,'FontSize',16)
    grid on
    set(gca,'YGrid','off')
    %ylim([-2 2.1])
    xlim(xlimits)
    ylabel('Amplitude')
    set(gca,'ytick',[0 1]);
    set(gca,'YTickLabel',[0 1]);
    
    if (seaweed_strength == seaweed_strength_min || seaweed_strength == seaweed_strength_max)
        %Determine locations of protraction retraction boxes
         tstep = t(2)-t(1);
         startnum = xlimits(1)/tstep
         endnum = xlimits(2)/tstep
         grasper_rel_pos = (swallow_bvec2(6,:)-swallow_bvec2(8,:));
         numProtractionBoxes = 0;
         numRetractionBoxes = 0;
         protraction = 1;
         protractionRectangles=[0,0];
         retractionRectangles=[0,0];
         for ind=startnum:endnum
            if grasper_rel_pos(ind) > grasper_rel_pos(ind-1)
                %protraction
                if(protraction == 0)
                    numProtractionBoxes=numProtractionBoxes+1;
                    protraction = 1;
                    %end the last retractionrectangle
                    if(numRetractionBoxes>0)
                        retractionRectangles(numRetractionBoxes,2) = ind;
                    end
                    %start a new protractionrectangle
                    protractionRectangles(numProtractionBoxes,1) = ind;
                end
            else
                %retraction
                if(protraction == 1)
                    numRetractionBoxes=numRetractionBoxes+1;
                    protraction = 0;
                    %end the last retractionrectangle            
                    retractionRectangles(numRetractionBoxes,1) = ind;
                    %start a new protractionrectangle
                    if(numProtractionBoxes>0)
                        protractionRectangles(numProtractionBoxes,2) = ind; 
                    end
                end     
            end
         end

         if retractionRectangles(end,2) ==0
             retractionRectangles(end,2) = endnum;
         end

         if protractionRectangles(end,2) ==0
             protractionRectangles(end,2) = endnum;
         end 
         
         positionAxesCell = get(gca,{'Position'});
        positionAxes = positionAxesCell{1};
        leftAxes = positionAxes(1)
        widthAxes = positionAxes(3)
        bottomAxes = positionAxes(2)+positionAxes(4)

        hold on
        for retract = 1:length(retractionRectangles)
        h=rectangle('Position', [retractionRectangles(retract,1)*tstep 1 (retractionRectangles(retract,2)-retractionRectangles(retract,1))*tstep 0.1]);  
        h.FaceColor = 'black';
        end
        hold off

        hold on
        for protract = 1:length(protractionRectangles)
        h=rectangle('Position', [protractionRectangles(protract,1)*tstep 1 (protractionRectangles(protract,2)-protractionRectangles(protract,1))*tstep 0.1]);  
        h.FaceColor = 'white';
        end
        hold off
    end
    
    if (seaweed_strength ~= seaweed_strength_max)
        set(gca,'XTickLabel',[]);
    end
    i=i+1;
end
xlabel('Time (s)')
saveas(gcf,['SeaweedStrength_' suffix '.png'])

%% Swallowing to rejection
t_switch = 19.95;
step_switch = t_switch/params{1,1};
chemicalAtLips = ones(1,nt);
chemicalAtLips(1,step_switch:nt) = zeros(1,length(step_switch:nt));
object_fixation = ones(1,nt); % is the object fixed (1) or not fixed (0)
object_fixation(1,step_switch:nt) = zeros(1,length(step_switch:nt));

mechanicalAtLips = ones(1,nt);
mechanicalInGrasper = ones(1,nt);
stim=zeros(13,nt);
seaweed_strength = 10;
[swallowToReject_avec,swallowToReject_bvec,swallowToReject_cvec] = Aplysia_boolean_model_withfriction(chemicalAtLips,mechanicalAtLips,mechanicalInGrasper,params,thresholds,modulation,stim,seaweed_strength, object_fixation);

Plot_behavior(t,swallowToReject_avec,swallowToReject_bvec,swallowToReject_cvec,['SwallowToReject_' suffix],xlimits,params{4,1},params)

%% Biting to swallowing
t_switch = 19.01;
step_switch = t_switch/params{1,1};
object_fixation = zeros(1,nt); % is the object fixed (1) or not fixed (0)
object_fixation(1,step_switch:nt) = ones(1,length(step_switch:nt));

chemicalAtLips = ones(1,nt);
mechanicalAtLips = ones(1,nt);
mechanicalInGrasper = zeros(1,nt);
mechanicalInGrasper(1,step_switch:nt) = ones(1,length(step_switch:nt));
stim=zeros(13,nt);
seaweed_strength = 10;
[biteToSwallow_avec,biteToSwallow_bvec,biteToSwallow_cvec] = Aplysia_boolean_model_withfriction(chemicalAtLips,mechanicalAtLips,mechanicalInGrasper,params,thresholds,modulation,stim,seaweed_strength, object_fixation);

Plot_behavior(t,biteToSwallow_avec,biteToSwallow_bvec,biteToSwallow_cvec,['BiteToSwallow_' suffix],xlimits,params{4,1},params)

%% B4/B5 Stimulation
% create stimulation pattern
tstep = params{1,1};
stim=zeros(13,nt);
t_transitionidx_1 = 250; % start stimulating B4/B5
t_transition_B4duration = 1/tstep; % in timesteps
stim(3,1:nt) = zeros(1,nt); % initialize extracellular stimulation of B4/B5
stim(3,t_transitionidx_1:(t_transitionidx_1+t_transition_B4duration)) = ones(1,length(stim(3,t_transitionidx_1:(t_transitionidx_1+t_transition_B4duration))));
stim(3,(t_transitionidx_1+t_transition_B4duration):end) = zeros(1,length(stim(3,(t_transitionidx_1+t_transition_B4duration):end)));

chemicalAtLips = ones(1,nt);
mechanicalAtLips = ones(1,nt);
mechanicalInGrasper = ones(1,nt);
object_fixation = ones(1,nt); % is the object fixed (1) or not fixed (0)
seaweed_strength = 10;
[B4B5stim_avec,B4B5stim_bvec,B4B5stim_cvec] = Aplysia_boolean_model_withfriction(chemicalAtLips,mechanicalAtLips,mechanicalInGrasper,params,thresholds,modulation,stim,seaweed_strength, object_fixation);

xlimits = [5 40];
figure1 = Plot_behavior(t,B4B5stim_avec,B4B5stim_bvec,B4B5stim_cvec,['B4B5stim_' suffix],xlimits,params{4,1},params)
% Create rectangle
totalwidth = 0.7;
totaltime = xlimits(2)-xlimits(1);
left = (t_transitionidx_1*tstep-xlimits(1))*totalwidth/totaltime+0.25;
width = t_transition_B4duration*tstep*totalwidth/totaltime;
bottom = 0.0738461538461538;
height = 0.768205128205128;
annotation(figure1,'rectangle',...
    [left bottom width height],...
    'Color',[0.635294139385223 0.0784313753247261 0.184313729405403],...
    'FaceColor',[1 0 0],...
    'FaceAlpha',0.25);

% Create rectangle
CBI3_refractory_duration = params{18,1}/1000/tstep;
left = left+width;
width = (CBI3_refractory_duration*tstep)*totalwidth/totaltime;
annotation(figure1,'rectangle',...
    [left bottom width height],...
    'Color',[0 0.450980392156863 0.741176470588235],...
    'FaceColor',[0.301960784313725 0.749019607843137 0.929411764705882],...
    'FaceAlpha',0.25);


%% Plotting swallowing vs. rejection vs. biting

xl=[0 params{3,1}]; % show full time scale

%Grasper Motion
figure
set(gcf,'Color','white')
hold on
plot(t,(swallow_bvec(6,:)-swallow_bvec(8,:)),'c','LineWidth',2)
plot(t,(reject_bvec(6,:)-reject_bvec(8,:)),'b','LineWidth',2)
plot(t,(bite_bvec(6,:)-bite_bvec(8,:)),'m','LineWidth',2)
hold off
legend('Swallow', 'Reject','Bite')
title('Relative Grasper Motion')
set(gca,'FontSize',16)
ylabel('Normalized Position')
grid on
xlim(xl)

%Force
figure
set(gcf,'Color','white')
hold on
plot(t,swallow_bvec(7,:),'c','LineWidth',2)
plot(t,reject_bvec(7,:),'b','LineWidth',2)
plot(t,bite_bvec(7,:),'m','LineWidth',2)
hold off
legend('Swallow', 'Reject','Bite')
title('Force on Seaweed')
set(gca,'FontSize',16)
ylabel('Force')
grid on
xlim(xl)

%subplots

subplot(3,1,1)
plot(t,swallow_bvec(7,:),'b','LineWidth',2)
hold on
plot(t,(swallow_bvec(6,:)-swallow_bvec(8,:)),'m','LineWidth',2)
legend('Force','Grasper Motion')
set(gca,'FontSize',16)
grid on
%ylim([-2 2.1])
xlim(xl)

subplot(3,1,2)
plot(t,reject_bvec(7,:),'b','LineWidth',2)
hold on
plot(t,(reject_bvec(6,:)-reject_bvec(8,:)),'m','LineWidth',2)
legend('Force','Grasper Motion')
set(gca,'FontSize',16)
grid on
%ylim([-2 2.1])
xlim(xl)

subplot(3,1,3)
plot(t,bite_bvec(7,:),'b','LineWidth',2)
hold on
plot(t,(bite_bvec(6,:)-bite_bvec(8,:)),'m','LineWidth',2)
legend('Force','Grasper Motion')
set(gca,'FontSize',16)
grid on
%ylim([-2 2.1])
xlim(xl)