clc; 
clear all;
close all;
%% Video Initialization
video_name = 'sample3.mp4'; %Video name
vid = VideoReader(video_name); 
nframes = vid.NumberOfFrames; %Number of frames
Height = vid.Height; % Height :)
Width = vid.Width; % Width :)
thr = 10; % Threshold for generating binary image of the noise
%% Kalman Filter Definition
% First, we define the state of interest. In this case, we define the
% following variables for our states: state(t) = [X Y dx dy (d^2)x (d^2)y](t)
% X(t+1) = 1/2(a)T^2 + V(t)T + X(t); where a and V denotes the acceleration
% and velocity respectively.
% V(t+1) = aT + V(t)
% a(t+1) = a(t) ; assuming constant acceleration 
%State(t+1) = A.State(t) + B.u + <State Uncertainty|State Noise>
dt=0.5;
% A = [1 0 dt 0 (dt^2)/2 0;
%      0 1 0  dt 0    (dt^2)/2;
%      0 0 1  0  dt    0;
%      0 0 0  1  0     dt;
%      0 0 0  0  1     0;
%      0 0 0  0  0     1];
A = [1 0 dt 0;
     0 1 0 dt;
     0 0 1 0 ;
     0 0 0 1 ;
     ];
B = [(dt^2)/2 (dt^2)/2 dt dt]';
%B = [(dt^2)/2 (dt^2)/2 dt dt 1 1]';
% B=0;
% Input to the system (here acceleration).
u = 4e-3;
%We are observing the X, and Y position. So our observation is: y = [X Y]
%y(t) = H.State(t) + <Measurement Noise>
% H = [1 0 0 0 0 0
%      0 1 0 0 0 0];
H = [1 0 0 0;
     0 1 0 0];
%%% Covariance Matrices : 
%I) Dynamic Noise, II) Measurement Noise, III) State Variables
% Now we define the state uncertainty; or, the state covariance matrix -> S(t)
% For simplicity we are assuming that the state variables are independet.
% The state variables are independet, so the covariance matrix is a diagonal matrix.
State_Uncertainty = 10;
S = State_Uncertainty * eye(size(A,1)); % The state variables are independet, so the covariance matrix is a diagonal matrix.
% Defining the <Measurement Noise> Covariance Matrix R
Meas_Unertainty = 1;
R = Meas_Unertainty * eye(size(H,1));
% Defining the Dynamic Noise covariance matrix
% Dynamic noise characterize the transition noise from one state to another
Dyn_Noise_Variance = (0.01)^2;
%Shahin = [(1/2)*(dt^2) (1/2)*(dt^2) dt dt 1 1]'; %Constant Acceleration
% Shahin = [(1/2)*(dt^2) (1/2)*(dt^2) dt dt]'; %Constant Velocity
%Q = Shahin*Shahin'*Dyn_Noise_Variance;
% Assuming the variables X and Y are independent
Q = [(dt^2)/4 0 (dt^3)/2 0;
     0 (dt^2)/4 0 (dt^3)/2;
     (dt^3/2) 0 (dt^2) 0;
     0 (dt^3)/2 0 (dt^2);
     ];

%% Kalman Variables (By the way I do not like Kalman filter, it has been overused)
Input = [];
x = [];
Kalman_Output = [];
% x = [Height/2; Width/2; 0; 0;0;-9.8]; % Initial Values
x = [Height/2; Width/2; 0; 0;]; % Initial Values

%% Extracting Background
background_frame = BackgroundExt(video_name);
%% Extract the noise
moving = zeros(Height,Width,nframes);
labeled_frames = zeros(Height,Width,nframes);
bb=0;
for i=1:nframes-1
    current_frame = double(read(vid,i));
    moving(:,:,i) = (abs(current_frame(:,:,1) - background_frame(:,:,1)) > thr)...
                   |(abs(current_frame(:,:,2) - background_frame(:,:,2)) > thr)...
                   |(abs(current_frame(:,:,3) - background_frame(:,:,3)) > thr);
    moving(:,:,i) = bwmorph(moving(:,:,i),'erode',2);
    labeled_frames(:,:,i) = bwlabel(moving(:,:,i),4); 
    stats{i} = regionprops(labeled_frames(:,:,i),'basic');
    [n_obj,features] = size(stats{i});
    area = 0;
    if(n_obj ~= 0) 
         for k=1:n_obj
             if(stats{i}(k).Area > area)
                id(i) = k;
                area = stats{i}(k).Area;
             end
         end
    centroid(:,:,i) = stats{i}(id(i)).Centroid;
    else
        centroid(:,:,i) = [rand*200 rand*200];
        bb = bb+1;
    end
    i %indicates the frame number
end
%% Marking Noise
for r=1:nframes-1
    frames = read(vid,r);
    frames = insertShape(frames,'circle',[centroid(1,1,r) centroid(1,2,r) sqrt(stats{r}(id(r)).Area/pi)],'LineWidth',1);
    marked_noise(:,:,:,r) = frames;
    %imshow(frames);
end
for r=1:nframes-1
    frames = read(vid,r);
    frames = insertShape(frames,'circle',[centroid(1,1,r) centroid(1,2,r) 4],'LineWidth',2);
    %%Kalman Update
     
    % Original Tracker.
    if(mod(r,2) == 0)
        input = [centroid(1,1,r); centroid(1,2,r)];
    else
        input=[];
    end
    
%     if(r>50)
%         input=[];
%     else
%         input = [centroid(1,1,r); centroid(1,2,r)];
%         frames = insertShape(frames,'circle',[centroid(1,1,r) centroid(1,2,r) 4],'LineWidth',2);
%     end
    % Estimate the next state
    x = A*x + B*u;
    % Estimate the error covariance 
    S = A*S*A' + Q;
    % Kalman Gain Calculations
    K = S*H'*inv(H*S*H'+R);
    % Update the estimation
    if(~isempty(input)) %Check if we have an input
        x = x + K*(input - H*x);
    end
    % Update the error covariance
    S = (eye(size(S,1)) - K*H)*S;
    % Save the measurements for plotting
    Kalman_Output = H*x;
    frames = insertShape(frames,'circle',[Kalman_Output(1) Kalman_Output(2) 4],'LineWidth',2,'Color','black');
    scenario_1(:,:,:,r) = frames;
    %imshow(frames)
    r
end
%% Showing the Video
%implay(read(vid));
%% Showing Background
%imshow(uint8(background_frame));
%% Extracted Noise Black and White
%implay(moving);
%% Marked Noise - Original Tracker
%implay(marked_noise(:,:,:,:));
%% Scenario 1 - Not Enough Samples
implay(scenario_1,15);