%  
%  
% [varargout] = svd_imrec(varargin) 
%  
%  
% DESCRIPTION 
% ------------------------------------------------------------------------| 
%  
%  
% INPUTS 
% ------------------------------------------------------------------------| 
%  
%  
% OUTPUTS 
% ------------------------------------------------------------------------| 
%  
%  
% NOTES 
% ------------------------------------------------------------------------| 
%  
%  
% Written 10/15/2013 
% By Sam Thorpe 


function [varargout] = svd_imrec(Nrcomp,varargin) 


% % LOAD IMAGE
M = imread('peppers.png');
M0 = double(M);


% % LOOP SVD RECONSTRUCT
if nargin<1 || isempty(Nrcomp)
    Nrcomp = 1; 
elseif Nrcomp>size(M0,1)
    Nrcomp = size(M0,1);
    disp('Warning! Specified number of SVD components to keep is too high...');
    disp(['Keeping maximum number = ',num2str(Nrcomp),' components.']);
end;
nR = length(Nrcomp);
Mr = zeros([size(M) nR]);
for k = 1:nR
    for q = 1:size(Mr,3)
        [U,S,V] = svd(squeeze(M0(:,:,q)));
        Mr(:,:,q,k) = U(:,1:Nrcomp(k))*S(1:Nrcomp(k),1:Nrcomp(k))*transpose(V(:,1:Nrcomp(k)));
    end
end


%                                 PLOTS 
% % ----------------------------------------------------------------------| 
%  


figure; image(uint8(M0)); axis('off');
title('peppers.png: original image','fontweight','bold','fontsize',15);  
for k = 1:nR
    figure; image(uint8(squeeze(Mr(:,:,:,k)))); axis('off');
    title(['peppers.png: reconstruction from ',num2str(Nrcomp(k)),...
          ' SVD components.'],'fontweight','bold','fontsize',15);
end


%                              SUBFUNCTIONS 
% % ----------------------------------------------------------------------| 
%  


%                                END ALL 
% % ----------------------------------------------------------------------| 
%  


