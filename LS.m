clear all;
tic %start timer to measure performance speed;
%Read all the data
[x,fs] = audioread('NoisySignal.wav');
[n,fs1] = audioread('NoiseRef1.wav');
[v,fs2] = audioread('NoiseRef2.wav');
% [xref,fsr] = audioread('spock.wav'); %%%%%PLEASE NOTE THIS SIGNAL IS USED ONLY IN CALCULATING FINAL ERROR, IT WAS FOUND ON INTERNET AFTER TEAM HAD THE IDEA OF THE DATA CONTENT AFTER FILTERING
N = size(x,1); %get the number of samples

figure(1);
subplot(3,1,1);
spectrogram(x,512,256,512,fs,'yaxis');
title('Noisy Signal');
subplot(3,1,2);
spectrogram(n,512,256,512,fs,'yaxis');
title('NoiseRef1(n)');
subplot(3,1,3);
spectrogram(v,512,256,512,fs,'yaxis');
title('NoiseRef2(v)');


L=250; % set the order for LS filter 
 
for ii = 1:2%number of "cleans"
  
[R,d] = lsmatvec('nowi',n,L,x); % no windowing, pretraining on n
hn = lscov(R,d); %get the LS filter coefficients 

errn(ii)=(x'*x-d'*hn)/N ;  %MMSE for n


% Filter signal for all N samples using the FIR co-efficients;
               
yn = filter(hn,1,n); %estimate of n

xout1 = x;% - yn;
[R,d] = lsmatvec('nowi',v,L,xout1); % no windowing
hv = lscov(R,d);

errv(ii)=(xout1'*xout1-d'*hv)/N;                 %MMSE for v
% Filter signal for all N samples using the pre-trained FIR co-efficients;
yv = filter(hv,1,v); 

xout2=xout1-yv-yn; %take away the estimates of noise from original noisy signal x

x = xout2;
end

%find the frequency of the hum:
df = fs / N;      
w = (-(N/2):(N/2)-1)*df;
y = fft(x(:,1), N) / N; 
y2 = fftshift(y);
figure(2);
plot(w,abs(y2));   %fft to see the freq analysis
title('Frequency analysis')

%Apply Band stop filter to silene 777Hz hum
nord = 7;
beginFreq = 705 / (fs/2);
endFreq = 835 / (fs/2);
[b,a] = butter(nord, [beginFreq, endFreq], 'stop');
x3 = filter(b, a, x);


pn = audioplayer(yn, fs);%player for noise 1
pv = audioplayer(yv, fs);%player for noise 2

figure (4);
spectrogram(x3,512,256,512,fs,'yaxis');
title('Enhanced Signal')
px = audioplayer(x3, fs);
audiowrite('EnhancedSignal.wav',x3, fs);
errv
errn
% Final_err=(xref-x3)'*(xref-x3)/N
toc