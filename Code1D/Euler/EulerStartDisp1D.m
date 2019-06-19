fprintf('Starting solve with DGANN for %s model, with the following parameters:\n',Problem.model)
fprintf('   test               : %s\n',Problem.test_name)
fprintf('   gas_gamma          : %.2f\n',Problem.gas_gamma)
fprintf('   gas_const          : %.2f\n',Problem.gas_const)
fprintf('   mesh               : [%.3f,%.3f] with %d elements\n',Mesh.bnd_l,Mesh.bnd_r,Mesh.K)
fprintf('   FinalTime          : %.2f\n',Problem.FinalTime)
fprintf('   CFL                : %.2f\n',Problem.CFL)

if(strcmp(Limit.Indicator,'NONE') || strcmp(Limit.Indicator,'ALL') || strcmp(Limit.Indicator,'MINMOD'))
    fprintf('   Indicator          : %s \n',Limit.Indicator)
elseif(strcmp(Limit.Indicator,'NN'))
    fprintf('   Indicator          : %s (%s)\n',Limit.Indicator, Limit.nn_model)
elseif(strcmp(Limit.Indicator,'TVB'))
    fprintf('   Indicator          : %s (M=%.2f)\n',Limit.Indicator,Limit.TVBM)
end

if(~strcmp(Limit.Indicator,'NONE') && ~strcmp(Limit.Indicator,'ALL'))
    fprintf('   Ind_Var            : %s \n',Limit.ind_var)
end

fprintf('   Limiter            : %s\n',Limit.Limiter)

if(~strcmp(Limit.Limiter,'NONE'))
    fprintf('   Lim_Var            : %s \n',Limit.lim_var)
end

switch Viscosity.model
    case 'NONE'
    fprintf('   Viscosity Model    : %s \n',Viscosity.model)
    
    case 'MDH'
    fprintf('   Viscosity Model    : %s (c_A=%.2f, c_k=%.2f, c_max=%.2f)\n',Viscosity.model,Viscosity.c_A,Viscosity.c_k,Viscosity.c_max)

    case 'MDA'
    fprintf('   Viscosity Model    : %s (c_max=%.2f)\n',Viscosity.model,Viscosity.c_max)
    
    case 'EV'
    fprintf('   Viscosity Model    : %s (c_E=%.2f, c_max=%.2f)\n',Viscosity.model,Viscosity.c_E,Viscosity.c_max)
    
    case 'NN'
    fprintf('   Viscosity Model    : %s (%s)\n',Viscosity.model, Viscosity.nn_visc_model)
end

if(~strcmp(Viscosity.visc_var,'NONE'))
    fprintf('   Visc_Var           : %s \n',Viscosity.visc_var)
end