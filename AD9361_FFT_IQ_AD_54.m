function [ output_args ] = AD9361_FFT_IQ_AD( input_args )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
   % input_args = '.\data_18.txt';
    NUM = 2^(10+10);     % FFT数据点
    Fs = 61.44;      % MHz

%  数据读取
    fid = fopen( input_args,'rb');
    data_i = fread(fid, NUM, 'bit16', 16);
    data_I = 1.3 * data_i / (2^12); 
    fseek(fid, 2, 'bof');
    data_q = fread(fid, NUM, 'bit16', 16);
    data_Q = 1.3 * data_q / (2^12); 
    data = complex(data_I, data_Q);
  %  zhb  
   qt_i=data_I(1:65536);
   qt_q=data_Q(1:65536);
   qt=qt_i+qt_q*j;
   bl=blackman(65536);
   qt_abl=qt.*bl;
   plot(20*log10(abs(fft(qt_abl))));
    
    
  %  zhb  
    
%  时域图
%     figure('Name',input_args);
%     x = [0:1:NUM-1];
%     subplot(3,1,1);
%     plot(x, data_I, '-r', x, data_Q, ':b');
%     
% % FFT预处理 
%     f = Fs * x / NUM;
%     
% % 频谱 IQ
%     fft_IQ = fft(data, NUM)/(NUM/2);
%     fft_IQ(1) = 2 * fft_IQ(1);
%     subplot(3,1,2);
%     MAG_IQ = 20*log10(abs(fft_IQ)) + 10;
%     plot(f, MAG_IQ);
%     nIndex = find(MAG_IQ == max(MAG_IQ));
%     str = sprintf('  F= %.6fMHz\r\n  P= %.1fdBm\r\n  D=%.1fDeg', f(nIndex(1)), MAG_IQ(nIndex(1)),angle(fft_IQ(nIndex(1))*180/pi));
%     text(f(nIndex(1)),MAG_IQ(nIndex(1)),str,'color','r');
%     
%     [mag, index] = findpeaks(MAG_IQ, 'SORTSTR', 'descend');
%     for pks = 2:3
%         %str = sprintf('  F= %.6fMHz\r\n  P= %.1fdBm\r\n',  f(index(pks)), MAG_IQ(index(pks)));
%         %text( f(index(pks)), MAG_IQ(index(pks)),str,'color','g');           
%     end
%     
%     subplot(3,1,3);
%     plot(fft_IQ);
    
%  关闭文件 
    fclose(fid);
end

