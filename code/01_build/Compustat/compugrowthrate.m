function g=compugrowthrate(y);

% Compute growth rates of a matrix like this:
%
% >> squeeze(sprc(:,:,n))
%
% ans =
%
%     1.0000    1.0001    1.2442    1.5184
%     1.0000    1.4275    2.3269    3.6015
%     1.0000    2.3916    4.0949    7.2970
%     1.0000    5.7437   14.1475   34.4565
%     1.0000   65.5085  296.2351  482.5016
% >> squeeze(sprc(:,:,3))

% ans =

%     1.0000    1.0004    1.0462       NaN
%     1.0000    1.5794    2.8357       NaN
%     1.0000    2.3539    4.9717       NaN
%     1.0000    3.9379    9.6490       NaN
%     1.0000  199.9800  269.7076       NaN
%     %
%  These are decades (1980s, 1990s, 2000s, 2010s)
%  so we take packr(log(.))/length(packr(.))

%global DHSGrowthRates;

[nrow,ncol]=size(y);
g=zeros(nrow,1)*NaN;

for i=1:nrow;
    yp=packr(y(i,:)');
    if ~isempty(yp);
        %g(i)=log(yp(end)/yp(1))./(10*(length(yp)-1));
        g(i,1)=log(yp(end)/yp(1))./(10*(length(yp)-1));
        halflife=abs(log(2)/g(i,1));
        g(i,2)=halflife;
    end;
end;

    
%fprintf('      Half life of idea TFP = %8.2f years\n',-log(2)/giTFP*100);
%fprintf('      Implied beta = %8.2f\n',-giTFP/mean(tfpgrowth));

    
    
    
    
    
    % smean_log2 =
%
%        NaN         0         0         0
%        NaN    1.4279    1.4613    1.6632
%        NaN       NaN    2.5494    2.6809
%        NaN       NaN       NaN    3.5304
%
% >> 2.^(smean_log2)
%
% ans =
%
%        NaN    1.0000    1.0000    1.0000
%        NaN    2.6906    2.7536    3.1672
%        NaN       NaN    5.8540    6.4126
%        NaN       NaN       NaN   11.5543