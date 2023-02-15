function [ output_args ] = AD9361_FFT_IQ_AD()
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
%    input_args = '.\data_5.txt';
%    NUM = 2^(10);     % FFT数据点
    N1 = 8192;
    NUM = N1/4;
    Fs = 61.44;      % MHz

%  数据读取

%    fid = fopen( input_args,'rb');
%    fseek(fid, 0, 'bof');
%    data_i = fread(fid, NUM, 'bit16', 48);
%    data_I = 1.3 * data_i / (2^12); 
%    fseek(fid, 2, 'bof');
%    data_q = fread(fid, NUM, 'bit16', 48);
%    data_Q = 1.3 * data_q / (2^12); 
%    data = complex(data_I, data_Q);


file_name='D:\iladata_2.csv';
tmp=importdata(file_name);
dat_mat_i=tmp.data(1:N1,2);
dat_mat_q=tmp.data(1:N1,3);
dat_mat1=dat_mat_i(1:4:N1);
dat_mat2=dat_mat_q(1:4:N1);
sdat_i=dat_mat1(:,1);
sdat_q=dat_mat2(:,1);
s_i = sdat_i;%%以下是将最高位为1的数据转换为负数
s_q = sdat_q;%%以下是将最高位为1的数据转换为负数

S = s_i + s_q*j;
    

data_i = s_i;
data_I = 1.3 * data_i / (2^12); 
data_q = s_q;
data_Q = 1.3 * data_q / (2^12); 
data = complex(data_I, data_Q);
%  时域图
%    figure('Name',input_args);
%    x = [0:1:NUM-1];
    x = (0:1:NUM-1);
    subplot(3,2,1);
    %plot(x, data_I, '-r', x, data_Q, ':b');
    plot(x, data_I, '-r', x, data_I, ':b');
% FFT预处理 
    f = Fs * x / NUM;
    
% 频谱 IQ
    fft_IQ = fft(data, NUM)/(NUM);
%    fft_IQ = fft(data, NUM)/(NUM/2);
    fft_IQ(1) = 2 * fft_IQ(1);
    subplot(3,2,2);
    MAG_IQ = 20*log10(abs(fft_IQ)) + 10;
    plot(f, MAG_IQ);
    nIndex = find(MAG_IQ == max(MAG_IQ));
    str = sprintf('  F= %.6fMHz\r\n  P= %.1fdBm\r\n  D=%.1fDeg', f(nIndex(1)), MAG_IQ(nIndex(1)),angle(fft_IQ(nIndex(1))*180/pi));
    text(f(nIndex(1)),MAG_IQ(nIndex(1)),str,'color','r');
    
    [mag, index] = findpeaks(MAG_IQ, 'SORTSTR', 'descend');
    for pks = 2:3
        %str = sprintf('  F= %.6fMHz\r\n  P= %.1fdBm\r\n',  f(index(pks)), MAG_IQ(index(pks)));
        %text( f(index(pks)), MAG_IQ(index(pks)),str,'color','g');           
    end
    
    subplot(3,2,3);
    plot(fft_IQ);
    
%-----wang---ss
%I  分析
    fft_I = fft(data_I, NUM)/(NUM);
%    fft_I(1) = 2 * fft_I(1);
    subplot(3,2,4);
    MAG_I = 20*log10(abs(fft_I)) + 10;
    plot(f, MAG_I);
    nIndex = find(MAG_I == max(MAG_I));
%    str = sprintf('  F= %.6fMHz\r\n  P= %.1fdBm\r\n  D=%.1fDeg', f(nIndex(1)), MAG_I(nIndex(1)),angle(fft_I(nIndex(1))*180/pi));
    str = sprintf('  nIndex=%d\r\n  F= %.6fMHz\r\n  P= %.1fdBm\r\n  D=%.1fDeg',nIndex(1), f(nIndex(1)), MAG_I(nIndex(1)),angle(fft_I(nIndex(1))*180/pi));
    F_I = f(nIndex(1))
    P_I = MAG_I(nIndex(1));
    P_I = MAG_I(nIndex(1)) + 3 
    Angel_I = angle(fft_I(nIndex(1))*180/pi) 
    text(f(nIndex(1)),MAG_I(nIndex(1)),str,'color','r');
    
%Q分析    
      fft_Q = fft(data_Q, NUM)/(NUM);
%    fft_I(1) = 2 * fft_I(1);
    subplot(3,2,5);
    MAG_Q = 20*log10(abs(fft_Q)) + 10;
    plot(f, MAG_Q);
    nIndex = find(MAG_Q == max(MAG_Q));
%    str = sprintf('  F= %.6fMHz\r\n  P= %.1fdBm\r\n  D=%.1fDeg', f(nIndex(1)), MAG_Q(nIndex(1)),angle(fft_Q(nIndex(1))*180/pi));
    
    str = sprintf('  nIndex=%d\r\n  F= %.6fMHz\r\n  P= %.1fdBm\r\n  D=%.1fDeg',nIndex(1), f(nIndex(1)), MAG_I(nIndex(1)),angle(fft_I(nIndex(1))*180/pi));
    F_Q = f(nIndex(1))
    P_Q = MAG_I(nIndex(1));
    P_Q = MAG_I(nIndex(1)) + 3 
    Angel_Q = angle(fft_I(nIndex(1))*180/pi) 
    
    phase_cha = Angel_Q - Angel_I,
    power_cha = P_Q - P_I ,
    fre_cha = F_Q - F_I ,
    
    
    
    text(f(nIndex(1)),MAG_I(nIndex(1)),str,'color','r');
%-----wang--end
end

