function [A, t] = estimate_affine(pts, pts_tilde)
    K = size(pts(1,:),2);
    be = reshape(pts_tilde,[],1);
    Ae = zeros(2*K,6);
    Ae(1:2:2*K,:) = [pts(1:2:2*K)' pts(2:2:2*K)' zeros(K,1) zeros(K,1) ones(K,1) zeros(K,1)];
    Ae(2:2:2*K,:) = [zeros(K,1) zeros(K,1) pts(1:2:2*K)' pts(2:2:2*K)' zeros(K,1) ones(K,1)];
    
    xe = Ae\be;
    A = [xe(1) xe(2); xe(3) xe(4)];
    t = xe(5:6);
end

