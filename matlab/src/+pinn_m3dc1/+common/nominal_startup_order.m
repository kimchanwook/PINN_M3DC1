function order = nominal_startup_order()
%NOMINAL_STARTUP_ORDER Return deterministic scaffold initialization order.

specs = pinn_m3dc1.common.registry();
[~, indices] = sort([specs.number]);
order = {specs(indices).id};
end

