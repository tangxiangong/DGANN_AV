function [q_lim] = Euler_cstencil(q,gas_gamma,gas_const,ind)

% Function converts conserved variable to characteristic variables
% locally on each 3-cell stencil, applies the limiter, and
% converts back to conserved variales

Globals1D_DG;

q_lim = q;

% Extend solution vector based on bc_type
rho_ext   = apply_bc(q(:,:,1));
mmt_ext   = apply_bc(q(:,:,2));
Ener_ext  = apply_bc(q(:,:,3));

%depthc = zeros(1,K); dischargec = zeros(1,K); Char = zeros(2,Np,3);

% Compute cell averages
rhoh = invV*rho_ext; rhoh(2:Np,:)=0;
rhoa = V*rhoh; rhoc = rhoa(1,:);

mmth = invV*mmt_ext; mmth(2:Np,:)=0;
mmta = V*mmth; mmtc = mmta(1,:);

Enerh = invV*Ener_ext; Enerh(2:Np,:)=0;
Enera = V*Enerh; Enerc = Enera(1,:);

% Compute characterisic variables
if(~isempty(ind))
    for i=1:length(ind)
        
        [L,invL] = EulerCharMat(rhoc(1,ind(i)+1),mmtc(1,ind(i)+1),...
                                Enerc(1,ind(i)+1),gas_gamma,gas_const);
        
        Char  = invL*[rho_ext(:,ind(i))', rho_ext(:,ind(i)+1)', rho_ext(:,ind(i)+2)';
                      mmt_ext(:,ind(i))', mmt_ext(:,ind(i)+1)', mmt_ext(:,ind(i)+2)'
                      Ener_ext(:,ind(i))', Ener_ext(:,ind(i)+1)', Ener_ext(:,ind(i)+2)'];
        
        Char1 = SlopeLimit3(reshape(Char(1,:,:),[Np,3]),x(:,ind(i)));
        Char2 = SlopeLimit3(reshape(Char(2,:,:),[Np,3]),x(:,ind(i)));
        Char3 = SlopeLimit3(reshape(Char(3,:,:),[Np,3]),x(:,ind(i)));
        
        U     = L*[Char1(:)';Char2(:)'; Char3(:)' ];

        q_lim(:,ind(i),1) = reshape(U(1,:,:),[Np,1]);
        q_lim(:,ind(i),2) = reshape(U(2,:,:),[Np,1]);
        q_lim(:,ind(i),3) = reshape(U(3,:,:),[Np,1]);        
    end
end


return;