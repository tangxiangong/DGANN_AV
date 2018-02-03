function ulimit = SlopeLimit(u,ind)

% Purpose: Apply slopelimiter (Pi^N) to u assuming u an N'th order polynomial            

Globals1D_DG;

ulimit = u;

if strcmp(rec_limiter,'none')
    return
else
     % Check to see if any elements require limiting
    if(~isempty(ind))
        
        % Extend solution vector based on bc_type
        u_ext  = apply_bc(u);
        
        ind_km1 = ind; 
        ind_k   = ind+1;
        ind_kp1 = ind+2;
    
        % Getting modal values
        uh = invV*u_ext; 
        
        % getting cell averages
        uavg = uh; uavg(2:Np,:)=0; uavg = V*uavg; v = uavg(1,:);
        vk = v(ind_k); vkm1 = v(ind_km1); vkp1 = v(ind_kp1);
        
        % create piecewise linear solution for limiting on specified elements
        uh(3:Np,:)=0; ul = V*uh(:,ind_k);
        
        % apply slope limiter to selected elements
        if strcmp(rec_limiter,'minmod')
            ulimit(:,ind) = SlopeLimitLin(ul,x(:,ind),vkm1,vk,vkp1);
        else
            error('Limiter %s not available!!',rec_limiter)
        end
    end

end
return