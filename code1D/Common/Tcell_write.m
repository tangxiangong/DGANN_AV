function Tcell_write(fid,t,xc)

fprintf(fid, '%.6f', t);
for k=1:length(xc)
    fprintf(fid, ', %.6f', xc);
end
fprintf(fid, '\n');

return