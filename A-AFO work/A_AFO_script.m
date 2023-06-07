clc
clear all
close all

files = dir('*.txt');


for i = 1:length(files)
    dlmread(files(i).name);
    data_init(i).name = erase(files(i).name,'.txt');
    data_init(i).values_init = importdata(files(i).name);
    data_init(i).values_init(:,1) = [];
    
end

'done reading'

clear i


for k = 1:3
    for m = 1:10
        for L = 1:2;
cond(k).type(m).limb(L).values = []; % create structure array into which all data will be stored
        end
    end
end


for i = 1:length(files)
    
    % condition
    if regexp(data_init(i).name,regexptranslate('wildcard','*noAFO*')) == 1
        logic(1) = 1;
    end
    if regexp(data_init(i).name,regexptranslate('wildcard','*AFO1*')) == 1
        logic(1) = 2;
    end
    if regexp(data_init(i).name,regexptranslate('wildcard','*AFO2*')) == 1
        logic(1) = 3;
    end
    
    % type
    if regexp(data_init(i).name,regexptranslate('wildcard','*ankleangle*')) == 1
        logic(2) = 1;
    end
    if regexp(data_init(i).name,regexptranslate('wildcard','*anklemoment*')) == 1
        logic(2) = 2;
        data_init(i).values_init  = -data_init(i).values_init;
    end
     if regexp(data_init(i).name,regexptranslate('wildcard','*kneeangle*')) == 1
        logic(2) = 3;
        %data_init(i).values_init  = -data_init(i).values_init;
     end
     if regexp(data_init(i).name,regexptranslate('wildcard','*kneemoment*')) == 1
        logic(2) = 4;
        %data_init(i).values_init  = -data_init(i).values_init;
     end
     if regexp(data_init(i).name,regexptranslate('wildcard','*hipangle*')) == 1
        logic(2) = 5;
        %data_init(i).values_init  = -data_init(i).values_init;
     end
     if regexp(data_init(i).name,regexptranslate('wildcard','*hipmoment*')) == 1
        logic(2) = 6;
        %data_init(i).values_init  = -data_init(i).values_init;
    end
    if regexp(data_init(i).name,regexptranslate('wildcard','*grf*')) == 1
        logic(2) = 7;
    end
    if regexp(data_init(i).name,regexptranslate('wildcard','*anklepower*')) == 1
        logic(2) = 8;
    end
    if regexp(data_init(i).name,regexptranslate('wildcard','*kneepower*')) == 1
        logic(2) = 9;
    end
    if regexp(data_init(i).name,regexptranslate('wildcard','*hippower*')) == 1
        logic(2) = 10;
    end
    
    % right & left
    if regexp(data_init(i).name,regexptranslate('wildcard','*L*')) == 1
        logic(3) = 1;
    end
    if regexp(data_init(i).name,regexptranslate('wildcard','*R*')) == 1
        logic(3) = 2;
    end
    
    I = logic(1);
    j = logic(2);
    L = logic(3);

    log(i,:) = logic; 
    
    % variable 'log' is a list of 3 identifiers for each .txt file
    % condition, type of data, L/R
    
end

'files loaded'

clear i j L

p = 0;

for i = 1:length(log)
        for k = (1:3).*2
            for L = 1:2
            if p > 0
               
            elseif log(i,1) == j && log(i,2) == k
                cond(log(i,1)).type(log(i,2)).limb(log(i,3)).values = [cond(log(i,1)).type(log(i,2)).limb(log(i,3)).values data_init(i).values_init];%.*subject_mass(j)];
                p = p+1;
            else
                cond(log(i,1)).type(log(i,2)).limb(log(i,3)).values = [cond(log(i,1)).type(log(i,2)).limb(log(i,3)).values data_init(i).values_init];
                p = p+1;
            end
            end
        end

    %%
    
    cond(log(i,1)).type(log(i,2)).limb(log(i,3)).avg = mean(cond(log(i,1)).type(log(i,2)).limb(log(i,3)).values,2,'omitnan');
    cond(log(i,1)).type(log(i,2)).limb(log(i,3)).std = std(cond(log(i,1)).type(log(i,2)).limb(log(i,3)).values,0,2);
    cond(log(i,1)).type(log(i,2)).limb(log(i,3)).peaks = max(cond(log(i,1)).type(log(i,2)).limb(log(i,3)).values); % for peak PF mom, init peak K ext mom, peak H flex ang/mom
    cond(log(i,1)).type(log(i,2)).limb(log(i,3)).peaks_avg = mean(cond(log(i,1)).type(log(i,2)).limb(log(i,3)).peaks);
    cond(log(i,1)).type(log(i,2)).limb(log(i,3)).peaks_std = std(cond(log(i,1)).type(log(i,2)).limb(log(i,3)).peaks);
    cond(log(i,1)).type(log(i,2)).limb(log(i,3)).mins = min(cond(log(i,1)).type(log(i,2)).limb(log(i,3)).values); % for peak PF ang, peak K flex ang, peak H ext ang
    cond(log(i,1)).type(log(i,2)).limb(log(i,3)).mins_avg = mean(cond(log(i,1)).type(log(i,2)).limb(log(i,3)).mins);
    cond(log(i,1)).type(log(i,2)).limb(log(i,3)).mins_std = mean(cond(log(i,1)).type(log(i,2)).limb(log(i,3)).mins);
    cond(log(i,1)).type(log(i,2)).limb(log(i,3)).init_mins = min(cond(log(i,1)).type(log(i,2)).limb(log(i,3)).values(1:100,:)); % for peak PF ang % init peak K flex ang
    cond(log(i,1)).type(log(i,2)).limb(log(i,3)).init_mins_avg = mean(cond(log(i,1)).type(log(i,2)).limb(log(i,3)).init_mins);
    cond(log(i,1)).type(log(i,2)).limb(log(i,3)).init_mins_std = std(cond(log(i,1)).type(log(i,2)).limb(log(i,3)).init_mins);
    cond(log(i,1)).type(log(i,2)).limb(log(i,3)).late_peaks = min(cond(log(i,1)).type(log(i,2)).limb(log(i,3)).values(100:end,:)); % for peak late K angle (low flexion)
    cond(log(i,1)).type(log(i,2)).limb(log(i,3)).late_peaks_avg = mean(cond(log(i,1)).type(log(i,2)).limb(log(i,3)).late_peaks);
    cond(log(i,1)).type(log(i,2)).limb(log(i,3)).late_peaks_std = std(cond(log(i,1)).type(log(i,2)).limb(log(i,3)).late_peaks);
    cond(log(i,1)).type(log(i,2)).limb(log(i,3)).late_mins = min(cond(log(i,1)).type(log(i,2)).limb(log(i,3)).values(100:end,:)); % for peak K flex ang/mom
    cond(log(i,1)).type(log(i,2)).limb(log(i,3)).late_mins_avg = mean(cond(log(i,1)).type(log(i,2)).limb(log(i,3)).late_mins);
    cond(log(i,1)).type(log(i,2)).limb(log(i,3)).late_mins_std = std(cond(log(i,1)).type(log(i,2)).limb(log(i,3)).late_mins);
    cond(log(i,1)).type(log(i,2)).limb(log(i,3)).init_peaks = min(cond(log(i,1)).type(log(i,2)).limb(log(i,3)).values(1:100,:)); % peak initial hip power
    cond(log(i,1)).type(log(i,2)).limb(log(i,3)).init_peaks_avg = mean(cond(log(i,1)).type(log(i,2)).limb(log(i,3)).init_peaks);
    cond(log(i,1)).type(log(i,2)).limb(log(i,3)).init_peaks_std = std(cond(log(i,1)).type(log(i,2)).limb(log(i,3)).init_peaks);
    cond(log(i,1)).type(log(i,2)).limb(log(i,3)).values = cond(log(i,1)).type(log(i,2)).limb(log(i,3)).values';
    


    p = 0;
    
end

'data collated'



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PLOTTING %%%%%%%%%%%

for c = 1:3;

figure
set(gcf,'color','w')

% Hip
subplot(3,3,1)
plot(cond(c).type(5).limb(1).avg,'b','Linewidth',3)
hold on
plot(cond(c).type(5).limb(2).avg,'r','Linewidth',3)
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -20 45])
if c == 1
    title('Hip angle - No AFO')
elseif c == 2
    title('Hip angle - AFO 1')
elseif c == 3
    title('Hip angle - AFO 2')
end
xlabel('% stance')
ylabel('Sagittal angle (degrees, +flex/-ext)')
legend('Unaffected limb','Affected limb')

subplot(3,3,2)
plot(cond(c).type(6).limb(1).avg,'b','Linewidth',3)
hold on
plot(cond(c).type(6).limb(2).avg,'r','Linewidth',3)
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -1.3 1])
title('Hip moment')
xlabel('% stance')
ylabel('Sagittal moment (N*m/kg,, +flex/-ext)')

subplot(3,3,3)
plot(cond(c).type(10).limb(1).avg,'b','Linewidth',3)
hold on
plot(cond(c).type(10).limb(2).avg,'r','Linewidth',3)
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -0.5 1.5])
title('Hip power')
xlabel('% stance')
ylabel('Sagittal power (W/kg, +flex/-ext)')

% Knee
subplot(3,3,4)

title('Knee angle')
plot(cond(c).type(3).limb(1).avg,'b','Linewidth',3)
hold on
plot(cond(c).type(3).limb(2).avg,'r','Linewidth',3)
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -60 10])
title('Knee angle')
xlabel('% stance')
ylabel('Sagittal angle (degrees, +ext/-flex)')

subplot(3,3,5)
plot(cond(c).type(4).limb(1).avg,'b','Linewidth',3)
hold on
plot(cond(c).type(4).limb(2).avg,'r','Linewidth',3)
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -0.6 0.6])
title('Knee moment')
xlabel('% stance')
ylabel('Sagittal moment (N*m/kg, +ext/-flex)')

subplot(3,3,6)
plot(cond(c).type(9).limb(1).avg,'b','Linewidth',3)
hold on
plot(cond(c).type(9).limb(2).avg,'r','Linewidth',3)
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -1.3 1.3])
title('Knee power')
xlabel('% stance')
ylabel('Sagittal power (W/kg, +ext/-flex)')

% Ankle
subplot(3,3,7)
plot(cond(c).type(1).limb(1).avg,'b','Linewidth',3)
hold on
plot(cond(c).type(1).limb(2).avg,'r','Linewidth',3)
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -10 25])
title('Ankle angle')
xlabel('% stance')
ylabel('Sagittal angle (degrees, +DF/-PF)')

subplot(3,3,8)
plot(cond(c).type(2).limb(1).avg,'b','Linewidth',3)
hold on
plot(cond(c).type(2).limb(2).avg,'r','Linewidth',3)
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -0.5 2])
title('Ankle moment')
xlabel('% stance')
ylabel('Safittal moment (N*m/kg, +PF/-DF)')

subplot(3,3,9)
plot(cond(c).type(8).limb(1).avg,'b','Linewidth',3)
hold on
plot(cond(c).type(8).limb(2).avg,'r','Linewidth',3)
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -2 4.3])
title('Ankle power')
xlabel('% stance')
ylabel('Sagittal power (W/kg, +PF/-DF)')

end



% transpose values for use in Statistical Parametric Mapping
for i = length(log)
cond(log(i,1)).type(log(i,2)).limb(log(i,3)).values = cond(log(i,1)).type(log(i,2)).limb(log(i,3)).values';
end

cond(1).type(9).limb(2).values = cond(1).type(9).limb(2).values';
%{
currentFolder = pwd;


%%%%%%%%%%%%%%%% NoAFO SPM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


cd 0todd0000-spm1dmatlab-eb8aa4c


clear i

figure
set(gcf,'color','w')


% Statistical Parametric Mapping calculations
for i = 1:10
stats(i).test = spm1d.stats.ttest_paired(cond(1).type(i).limb(1).values,cond(1).type(i).limb(2).values);
stats(i).inference_type = stats(i).test.inference(0.05,'two_tailed',true);
end


% SPM plotting

subplot(3,3,1)
stats(5).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Hip angle - NoAFO')
xlabel('% stance')

subplot(3,3,2)
stats(6).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Hip moment')
xlabel('% stance')

subplot(3,3,3)
stats(10).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Hip power')
xlabel('% stance')

subplot(3,3,4)
stats(3).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Knee angle')
xlabel('% stance')

subplot(3,3,5)
stats(4).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Knee moment')
xlabel('% stance')

subplot(3,3,6)
stats(9).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Knee power')
xlabel('% stance')

subplot(3,3,7)
stats(1).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Ankle angle')
xlabel('% stance')

subplot(3,3,8)
stats(2).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Ankle moment')
xlabel('% stance')

subplot(3,3,9)
stats(8).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Ankle power')
xlabel('% stance')

%%%%%%%%%%% AFO1 SPM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear i

figure
set(gcf,'color','w')


% Statistical Parametric Mapping calculations
for i = 1:10
stats(i).test = spm1d.stats.ttest_paired(cond(2).type(i).limb(1).values(1:134,:),cond(2).type(i).limb(2).values);
stats(i).inference_type = stats(i).test.inference(0.05,'two_tailed',true);
end


% SPM plotting

subplot(3,3,1)
stats(5).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Hip angle - AFO1')
xlabel('% stance')

subplot(3,3,2)
stats(6).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Hip moment')
xlabel('% stance')

subplot(3,3,3)
stats(10).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Hip power')
xlabel('% stance')

subplot(3,3,4)
stats(3).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Knee angle')
xlabel('% stance')

subplot(3,3,5)
stats(4).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Knee moment')
xlabel('% stance')

subplot(3,3,6)
stats(9).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Knee power')
xlabel('% stance')

subplot(3,3,7)
stats(1).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Ankle angle')
xlabel('% stance')

subplot(3,3,8)
stats(2).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Ankle moment')
xlabel('% stance')

subplot(3,3,9)
stats(8).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Ankle power')
xlabel('% stance')


%%%%%%%%%%%% AFO2 SPM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear i

figure
set(gcf,'color','w')


% Statistical Parametric Mapping calculations
for i = 1:10
stats(i).test = spm1d.stats.ttest_paired(cond(3).type(i).limb(1).values,cond(3).type(i).limb(2).values(1:62,:));
stats(i).inference_type = stats(i).test.inference(0.05,'two_tailed',true);
end


% SPM plotting

subplot(3,3,1)
stats(5).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Hip angle - AFO2')
xlabel('% stance')

subplot(3,3,2)
stats(6).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Hip moment')
xlabel('% stance')

subplot(3,3,3)
stats(10).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Hip power')
xlabel('% stance')

subplot(3,3,4)
stats(3).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Knee angle')
xlabel('% stance')

subplot(3,3,5)
stats(4).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Knee moment')
xlabel('% stance')

subplot(3,3,6)
stats(9).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Knee power')
xlabel('% stance')

subplot(3,3,7)
stats(1).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Ankle angle')
xlabel('% stance')

subplot(3,3,8)
stats(2).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Ankle moment')
xlabel('% stance')

subplot(3,3,9)
stats(8).inference_type.plot()
xticks([0 50 100 150 200])
xticklabels([0 25 50 75 100])
axis([0 200 -50 100])
title('Ankle power')
xlabel('% stance')


cd(currentFolder)
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RMSE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear i j k 

for i = 1:3
    for j = 1:10

cond(i).type(j).limb(1).RMSE = sqrt(sum((cond(i).type(j).limb(1).avg - cond(i).type(j).limb(2).avg).^2));

    end
end

% NoAFO
cond(1).RMSE(1,1) = cond(1).type(5).limb(1).RMSE;
cond(1).RMSE(1,2) = cond(1).type(6).limb(1).RMSE;
cond(1).RMSE(1,3) = cond(1).type(10).limb(1).RMSE;
cond(1).RMSE(2,1) = cond(1).type(3).limb(1).RMSE;
cond(1).RMSE(2,2) = cond(1).type(4).limb(1).RMSE;
cond(1).RMSE(2,3) = cond(1).type(9).limb(1).RMSE;
cond(1).RMSE(3,1) = cond(1).type(1).limb(1).RMSE;
cond(1).RMSE(3,2) = cond(1).type(2).limb(1).RMSE;
cond(1).RMSE(3,3) = cond(1).type(8).limb(1).RMSE;

% AFO1
cond(2).RMSE(1,1) = cond(2).type(5).limb(1).RMSE;
cond(2).RMSE(1,2) = cond(2).type(6).limb(1).RMSE;
cond(2).RMSE(1,3) = cond(2).type(10).limb(1).RMSE;
cond(2).RMSE(2,1) = cond(2).type(3).limb(1).RMSE;
cond(2).RMSE(2,2) = cond(2).type(4).limb(1).RMSE;
cond(2).RMSE(2,3) = cond(2).type(9).limb(1).RMSE;
cond(2).RMSE(3,1) = cond(2).type(1).limb(1).RMSE;
cond(2).RMSE(3,2) = cond(2).type(2).limb(1).RMSE;
cond(2).RMSE(3,3) = cond(2).type(8).limb(1).RMSE;

% AFO2
cond(3).RMSE(1,1) = cond(3).type(5).limb(1).RMSE;
cond(3).RMSE(1,2) = cond(3).type(6).limb(1).RMSE;
cond(3).RMSE(1,3) = cond(3).type(10).limb(1).RMSE;
cond(3).RMSE(2,1) = cond(3).type(3).limb(1).RMSE;
cond(3).RMSE(2,2) = cond(3).type(4).limb(1).RMSE;
cond(3).RMSE(2,3) = cond(3).type(9).limb(1).RMSE;
cond(3).RMSE(3,1) = cond(3).type(1).limb(1).RMSE;
cond(3).RMSE(3,2) = cond(3).type(2).limb(1).RMSE;
cond(3).RMSE(3,3) = cond(3).type(8).limb(1).RMSE;

%%%%%%%%%%%%%%%%%%%%%%%%%% LSI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear i l k L m p

for i = 1:3

        cond(i).type(1).limb(1).LSI = (cond(i).type(1).limb(2).peaks_avg/cond(i).type(1).limb(1).peaks_avg)*100;
        cond(i).type(2).limb(1).LSI = (cond(i).type(2).limb(2).peaks_avg/cond(i).type(2).limb(1).peaks_avg)*100;
        cond(i).type(3).limb(1).LSI = (cond(i).type(3).limb(2).late_peaks_avg/cond(i).type(3).limb(1).late_peaks_avg)*100;
        cond(i).type(4).limb(1).LSI = (cond(i).type(4).limb(2).peaks_avg/cond(i).type(4).limb(1).peaks_avg)*100;
        cond(i).type(5).limb(1).LSI = (cond(i).type(5).limb(2).peaks_avg/cond(i).type(5).limb(1).peaks_avg)*100;
        cond(i).type(6).limb(1).LSI = (cond(i).type(6).limb(2).mins_avg/cond(i).type(6).limb(1).mins_avg)*100;
        cond(i).type(8).limb(1).LSI = (cond(i).type(8).limb(2).peaks_avg/cond(i).type(8).limb(1).peaks_avg)*100;
        cond(i).type(9).limb(1).LSI = (cond(i).type(9).limb(2).late_peaks_avg/cond(i).type(9).limb(1).late_peaks_avg)*100;
        cond(i).type(10).limb(1).LSI = (cond(i).type(10).limb(2).init_peaks_avg/cond(i).type(10).limb(1).init_peaks_avg)*100;
        
    if i == 1
        LSI_noAFO = [cond(i).type(1).limb(1).LSI; cond(i).type(2).limb(1).LSI; cond(i).type(8).limb(1).LSI; cond(i).type(3).limb(1).LSI; cond(i).type(4).limb(1).LSI; cond(i).type(9).limb(1).LSI; cond(i).type(5).limb(1).LSI; cond(i).type(6).limb(1).LSI; cond(i).type(10).limb(1).LSI];
    end

    if i == 2
        LSI_AFO1 = [cond(i).type(1).limb(1).LSI; cond(i).type(2).limb(1).LSI; cond(i).type(8).limb(1).LSI; cond(i).type(3).limb(1).LSI; cond(i).type(4).limb(1).LSI; cond(i).type(9).limb(1).LSI; cond(i).type(5).limb(1).LSI; cond(i).type(6).limb(1).LSI; cond(i).type(10).limb(1).LSI];
    end

    if i == 3
        LSI_AFO2 = [cond(i).type(1).limb(1).LSI; cond(i).type(2).limb(1).LSI; cond(i).type(8).limb(1).LSI; cond(i).type(3).limb(1).LSI; cond(i).type(4).limb(1).LSI; cond(i).type(9).limb(1).LSI; cond(i).type(5).limb(1).LSI; cond(i).type(6).limb(1).LSI; cond(i).type(10).limb(1).LSI];
    end
    
end

LSI = [LSI_noAFO, LSI_AFO1, LSI_AFO2];



%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Trend Symmetry (Crenshaw & Richards 2005)


for i = 1:3
    figure
    set(gcf,'color','w')
    for j = 1:10
        if size(cond(i).type(j).limb(1).values,1) > size(cond(i).type(j).limb(2).values,1)
            k = size(cond(i).type(j).limb(2).values,1);
        else k = size(cond(i).type(j).limb(1).values,1);
        end
        for k = k

T1(:,k) = (cond(i).type(j).limb(1).values(k,:) - mean(cond(i).type(j).limb(1).values(k,:)))';
T2(:,k) = (cond(i).type(j).limb(2).values(k,:) - mean(cond(i).type(j).limb(2).values(k,:)))';

M = [T1(:,k) T2(:,k)];

S = M'*M;

[S_eigvect,S_eigval] = eig(S);

X = min(M(:,1)):0.1:max(M(:,1));
X_axis = [1,0];
Y_axis = [0,1];

theta = rad2deg(acos(dot(S_eigvect(:,2),X_axis)/(norm(S_eigvect(:,2))*norm(X_axis))));

R = [cosd(theta) sind(theta); -sind(theta) cosd(theta)];

for z = 1:size(M,1)
M_rot(z,:) = R*(M(z,:)');
end

cond(i).type(j).limb(1).trend_symmetry = var(M_rot(:,2))/var(M_rot(:,1));

M_reg = polyfit(M(:,1),M(:,2),1);


if j == 1
subplot(3,3,7)
plot(M(:,1),M(:,2))
hold on
plot(X,M_reg(1).*X,'k--')
hold on
plot(X,(S_eigvect(1,2)/S_eigvect(2,2).*X),'k')
hold off
title('Ankle Angle')
elseif j == 2
subplot(3,3,8)
plot(M(:,1),M(:,2))
hold on
plot(X,M_reg(1).*X,'k--')
hold on
plot(X,(S_eigvect(1,2)/S_eigvect(2,2).*X),'k')
hold off
title('Ankle Moment')
elseif j == 3
subplot(3,3,4)
plot(M(:,1),M(:,2))
hold on
plot(X,M_reg(1).*X,'k--')
hold on
plot(X,(S_eigvect(1,2)/S_eigvect(2,2).*X),'k')
hold off
title('Knee Angle')
elseif j == 4
subplot(3,3,5)
plot(M(:,1),M(:,2))
hold on
plot(X,M_reg(1).*X,'k--')
hold on
plot(X,(S_eigvect(1,2)/S_eigvect(2,2).*X),'k')
hold off
title('Knee Moment')
elseif j == 5
subplot(3,3,1)
plot(M(:,1),M(:,2))
hold on
plot(X,M_reg(1).*X,'k--')
hold on
plot(X,(S_eigvect(1,2)/S_eigvect(2,2).*X),'k')
hold off
title('Hip Angle')
elseif j == 6
subplot(3,3,2)
plot(M(:,1),M(:,2))
hold on
plot(X,M_reg(1).*X,'k--')
hold on
plot(X,(S_eigvect(1,2)/S_eigvect(2,2).*X),'k')
hold off
title('Hip Moment')
elseif j == 8
subplot(3,3,9)
plot(M(:,1),M(:,2))
hold on
plot(X,M_reg(1).*X,'k--')
hold on
plot(X,(S_eigvect(1,2)/S_eigvect(2,2).*X),'k')
hold off
title('Ankle Power')
elseif j == 9
subplot(3,3,6)
plot(M(:,1),M(:,2))
hold on
plot(X,M_reg(1).*X,'k--')
hold on
plot(X,(S_eigvect(1,2)/S_eigvect(2,2).*X),'k')
hold off
title('Knee Power')
elseif j == 10
subplot(3,3,3)
plot(M(:,1),M(:,2))
hold on
plot(X,M_reg(1).*X,'k--')
hold on
plot(X,(S_eigvect(1,2)/S_eigvect(2,2).*X),'k')
hold off
title('Hip Power')
end


clear M S theta R M_rot

        end
    end
end

% NoAFO
cond(1).trend_symmetry(1,1) = cond(1).type(5).limb(1).trend_symmetry;
cond(1).trend_symmetry(1,2) = cond(1).type(6).limb(1).trend_symmetry;
cond(1).trend_symmetry(1,3) = cond(1).type(10).limb(1).trend_symmetry;
cond(1).trend_symmetry(2,1) = cond(1).type(3).limb(1).trend_symmetry;
cond(1).trend_symmetry(2,2) = cond(1).type(4).limb(1).trend_symmetry;
cond(1).trend_symmetry(2,3) = cond(1).type(9).limb(1).trend_symmetry;
cond(1).trend_symmetry(3,1) = cond(1).type(1).limb(1).trend_symmetry;
cond(1).trend_symmetry(3,2) = cond(1).type(2).limb(1).trend_symmetry;
cond(1).trend_symmetry(3,3) = cond(1).type(8).limb(1).trend_symmetry;

% AFO1
cond(2).trend_symmetry(1,1) = cond(2).type(5).limb(1).trend_symmetry;
cond(2).trend_symmetry(1,2) = cond(2).type(6).limb(1).trend_symmetry;
cond(2).trend_symmetry(1,3) = cond(2).type(10).limb(1).trend_symmetry;
cond(2).trend_symmetry(2,1) = cond(2).type(3).limb(1).trend_symmetry;
cond(2).trend_symmetry(2,2) = cond(2).type(4).limb(1).trend_symmetry;
cond(2).trend_symmetry(2,3) = cond(2).type(9).limb(1).trend_symmetry;
cond(2).trend_symmetry(3,1) = cond(2).type(1).limb(1).trend_symmetry;
cond(2).trend_symmetry(3,2) = cond(2).type(2).limb(1).trend_symmetry;
cond(2).trend_symmetry(3,3) = cond(2).type(8).limb(1).trend_symmetry;

% AFO2
cond(3).trend_symmetry(1,1) = cond(3).type(5).limb(1).trend_symmetry;
cond(3).trend_symmetry(1,2) = cond(3).type(6).limb(1).trend_symmetry;
cond(3).trend_symmetry(1,3) = cond(3).type(10).limb(1).trend_symmetry;
cond(3).trend_symmetry(2,1) = cond(3).type(3).limb(1).trend_symmetry;
cond(3).trend_symmetry(2,2) = cond(3).type(4).limb(1).trend_symmetry;
cond(3).trend_symmetry(2,3) = cond(3).type(9).limb(1).trend_symmetry;
cond(3).trend_symmetry(3,1) = cond(3).type(1).limb(1).trend_symmetry;
cond(3).trend_symmetry(3,2) = cond(3).type(2).limb(1).trend_symmetry;
cond(3).trend_symmetry(3,3) = cond(3).type(8).limb(1).trend_symmetry;

% NoAFO
trend_symmetry1(1,1) = cond(1).type(5).limb(1).trend_symmetry;
trend_symmetry1(1,2) = cond(1).type(6).limb(1).trend_symmetry;
trend_symmetry1(1,3) = cond(1).type(10).limb(1).trend_symmetry;
trend_symmetry1(2,1) = cond(1).type(3).limb(1).trend_symmetry;
trend_symmetry1(2,2) = cond(1).type(4).limb(1).trend_symmetry;
trend_symmetry1(2,3) = cond(1).type(9).limb(1).trend_symmetry;
trend_symmetry1(3,1) = cond(1).type(1).limb(1).trend_symmetry;
trend_symmetry1(3,2) = cond(1).type(2).limb(1).trend_symmetry;
trend_symmetry1(3,3) = cond(1).type(8).limb(1).trend_symmetry;

% AFO1
trend_symmetry2(1,1) = cond(2).type(5).limb(1).trend_symmetry;
trend_symmetry2(1,2) = cond(2).type(6).limb(1).trend_symmetry;
trend_symmetry2(1,3) = cond(2).type(10).limb(1).trend_symmetry;
trend_symmetry2(2,1) = cond(2).type(3).limb(1).trend_symmetry;
trend_symmetry2(2,2) = cond(2).type(4).limb(1).trend_symmetry;
trend_symmetry2(2,3) = cond(2).type(9).limb(1).trend_symmetry;
trend_symmetry2(3,1) = cond(2).type(1).limb(1).trend_symmetry;
trend_symmetry2(3,2) = cond(2).type(2).limb(1).trend_symmetry;
trend_symmetry2(3,3) = cond(2).type(8).limb(1).trend_symmetry;

% AFO2
trend_symmetry3(1,1) = cond(3).type(5).limb(1).trend_symmetry;
trend_symmetry3(1,2) = cond(3).type(6).limb(1).trend_symmetry;
trend_symmetry3(1,3) = cond(3).type(10).limb(1).trend_symmetry;
trend_symmetry3(2,1) = cond(3).type(3).limb(1).trend_symmetry;
trend_symmetry3(2,2) = cond(3).type(4).limb(1).trend_symmetry;
trend_symmetry3(2,3) = cond(3).type(9).limb(1).trend_symmetry;
trend_symmetry3(3,1) = cond(3).type(1).limb(1).trend_symmetry;
trend_symmetry3(3,2) = cond(3).type(2).limb(1).trend_symmetry;
trend_symmetry3(3,3) = cond(3).type(8).limb(1).trend_symmetry;

%%



























