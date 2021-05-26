function [R,d]=lsmatvec(method,x,M,y)
% function [R,d]=lsmatvec(method,x,M,y)
% Computes the MxM normal equations matrix
% and the right-hand side vector of the LS NE
% method='prew','post','full', or 'nowi'
% Programmed by Dimitris Manolakis, 6/1/97
%
%-----------------------------------------------------------
% Copyright 2000, by Dimitris G. Manolakis, Vinay K. Ingle,
% and Stephen M. Kogon.  For use with the book
% "Statistical and Adaptive Signal Processing"
% McGraw-Hill Higher Education.
%-----------------------------------------------------------


R=zeros(M,M);
d=zeros(M,1);

if method=='prew'
   x=[zeros(1,M-1),x']';
   y=[zeros(1,M-1),y']';
elseif method=='full'
   x=[zeros(1,M-1),x',zeros(1,M-1)]';
   y=[zeros(1,M-1),y',zeros(1,M-1)]';
elseif method=='post'
   x=[x',zeros(1,M-1)]';
   y=[y',zeros(1,M-1)]';
elseif method=='nowi'
end
   
N=length(x);
 
for j=1:M
   R(1,j)=x(M:N)'*x(M+1-j:N+1-j);
   R(j,1)=R(1,j);
end  

for i=2:M
   for j=i:M
      R(i,j)=R(i-1,j-1)+x(M+1-i)*x(M+1-j)-x(N+2-i)*x(N+2-j); 
      R(j,i)=R(i,j);
   end
end

if nargin==4
   for j=1:M
      d(j)=x(M+1-j:N+1-j)'*y(M:N);
   end
else
end  

   

