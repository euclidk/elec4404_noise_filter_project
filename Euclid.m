% -------------------------------------------------------------------------
% Get Inputs
% -------------------------------------------------------------------------
[sample_x, Fs_x] = audioread('NoisySignal.wav');    % Noisy Signal
[sample_v1, Fs_v1] = audioread('NoiseRef1.wav');    % Theme tune
[sample_v2, Fs_v2] = audioread('NoiseRef2.wav');    % Crowd noise

% -------------------------------------------------------------------------
% Filtering
% -------------------------------------------------------------------------

% ...
% ...
% ...

cleaned_signal = sample_x;   % Cleaned signal
Fs = Fs_x;      % Sampling frequency

% -------------------------------------------------------------------------
% Outputs
% -------------------------------------------------------------------------

% Plot the spectrogram
spectrogram(cleaned_signal, 512, 256, 512, Fs, 'yaxis');
colorbar;
colormap gray;

% Write out the signal to a .WAV file for listening
audiowrite('Output_.wav', cleaned_signal, Fs);

% Alternatively...
%   >>> sound(cleaned_signal)
% will play the signal in MATLAB
% Use this cmd to stop it:
%   >>> clear sound
