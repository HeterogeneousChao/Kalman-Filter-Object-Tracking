function [ background_frame ] = BackgroundExt( input_video )
% This script make a background frame based on the samples of the frames. That is, it takes the average of the 
% frames and save the result as the background frame
% If you have the background frame, then you can use it directly. We are
% using averaging because we do not have access to the background image,
% and by averaging we can supress the effect of moving objects in the
% resulting frame and have a better estimation of background frame.
sample_step = 2;
vid = VideoReader(input_video);
%vid = VideoReader('sample.mov');
%frame = vid.read(inf);
Height = vid.height;
Width = vid.width;
nframes = vid.NumberOfFrames; %Number of frames
background = zeros(Height,Width,3); %Initial Background Image
%% First Stage: averaging over all of the background samples
for i=1:sample_step:nframes-sample_step
    background = background + double(read(vid,i));
end
background = sample_step*background/(nframes);
%imshow(uint8(background));
background_frame = background;
end
