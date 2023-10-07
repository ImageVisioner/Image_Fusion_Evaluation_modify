clc
clear all
tic
easy =0;

source_folder1 = '.\image\m3fd\thermal\'; %红外图像路径
source_folder2 = '.\image\m3fd\visual\'; %可见光图像路径
fused_folder = '.\image\fuse\'; % 融合图像路径

files1 = dir(fullfile(source_folder1, '*.png')); %获取红外图像文件夹下的所有.bmp文件
files2 = dir(fullfile(source_folder2, '*.png')); %获取可见光图像文件夹下的所有.bmp文件
fused_files = dir(fullfile(fused_folder, '*.bmp')); %获取融合图像文件夹下的所有文件

% 初始化指标值
total_EN = 0;
total_SF = 0;
total_SD = 0;
total_PSNR = 0;
total_MSE = 0;
total_MI = 0;
total_VIF = 0;
total_AG = 0;
total_CC = 0;
total_SCD = 0;
total_Qabf = 0;
total_Nabf = 0;
total_SSIM = 0;
total_MS_SSIM = 0;
total_FMI_pixel = 0;
total_FMI_dct = 0;
total_FMI_w = 0;


for k = 1:length(fused_files)
    disp(k)

    ir_image = imread(fullfile(source_folder1, files1(k).name));
    vi_image = imread(fullfile(source_folder2, files2(k).name));
    fused_image = imread(fullfile(fused_folder, fused_files(k).name));

    if size(ir_image, 3)>2
        ir_image = im2gray(ir_image);
    end

    if size(vi_image, 3)>2
        vi_image = im2gray(vi_image);
    end

    if size(fused_image, 3)>2
        fused_image = im2gray(fused_image);
    end

    % 计算指标并将值加到总和中
    [EN, SF,SD,PSNR,MSE, MI, VIF, AG, CC, SCD, Qabf, Nabf, SSIM, MS_SSIM, FMI_pixel, FMI_dct, FMI_w] = analysis_Reference(fused_image,ir_image,vi_image, easy);

    total_EN = total_EN + EN;
    total_SF = total_SF + SF;
    total_SD = total_SD + SD;
    total_PSNR = total_PSNR + PSNR;
    total_MSE = total_MSE + MSE;
    total_MI = total_MI + MI;
    total_VIF = total_VIF + VIF;
    total_AG = total_AG + AG;
    total_CC = total_CC + CC;
    total_SCD = total_SCD + SCD;
    total_Qabf = total_Qabf + Qabf;
    total_Nabf = total_Nabf + Nabf;
    total_SSIM = total_SSIM + SSIM;
    total_MS_SSIM = total_MS_SSIM + MS_SSIM;
    total_FMI_pixel = total_FMI_pixel + FMI_pixel;
    total_FMI_dct = total_FMI_dct + FMI_dct;
    total_FMI_w = total_FMI_w + FMI_w;
    toc
end

% 计算平均值并输出
average_EN = total_EN / length(fused_files);
average_SF = total_SF / length(fused_files);
average_SD = total_SD / length(fused_files);
average_PSNR = total_PSNR / length(fused_files);
average_MSE = total_MSE / length(fused_files);
average_MI = total_MI / length(fused_files);
average_VIF = total_VIF / length(fused_files);
average_AG = total_AG / length(fused_files);
average_CC = total_CC / length(fused_files);
average_SCD = total_SCD / length(fused_files);
average_Qabf = total_Qabf / length(fused_files);
average_Nabf = total_Nabf / length(fused_files);
average_SSIM = total_SSIM / length(fused_files);
average_MS_SSIM = total_MS_SSIM / length(fused_files);
average_FMI_pixel = total_FMI_pixel / length(fused_files);
average_FMI_dct = total_FMI_dct / length(fused_files);
average_FMI_w = total_FMI_w / length(fused_files);

fprintf('Average EN = %.4f\n', average_EN)
fprintf('Average SF = %.4f\n', average_SF)
fprintf('Average SD = %.4f\n', average_SD)
fprintf('Average PSNR = %.4f\n', average_PSNR)
fprintf('Average MSE = %.4f\n', average_MSE)
fprintf('Average MI = %.4f\n', average_MI)
fprintf('Average VIF = %.4f\n', average_VIF)
fprintf('Average AG = %.4f\n', average_AG)
fprintf('Average CC = %.4f\n', average_CC)
fprintf('Average SCD = %.4f\n', average_SCD)
fprintf('Average Qabf = %.4f\n', average_Qabf)
fprintf('Average Nabf = %.4f\n', average_Nabf)
fprintf('Average SSIM = %.4f\n', average_SSIM)
fprintf('Average MS_SSIM = %.4f\n', average_MS_SSIM)
fprintf('Average FMI_pixel = %.4f\n', average_FMI_pixel)
fprintf('Average FMI_dct = %.4f\n', average_FMI_dct)
fprintf('Average FMI_w = %.4f\n', average_FMI_w)
toc

