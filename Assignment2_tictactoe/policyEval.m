function vpi = policyEval(P, R, gamma, pi, v)

S = size(P,1); % n stati che ho a disposizione
Ppi = zeros(S,S);
Rpi = zeros(S,1);
for s = 1:S
    Ppi(s,:) = P(s,:,pi(s));  % la matrix è data dalla P relativa allo stato s attuale, tutti gli stati next, e l'azione associata allo stato s
    Rpi(s) = R(s,pi(s)); 
end

while true
    vprec = v;
    v = Rpi + gamma*Ppi*vprec;
    if norm(vprec-v, Inf) < 1e-6 % se arrivo a convergenza interrompo
        break
    end
end

vpi = v;