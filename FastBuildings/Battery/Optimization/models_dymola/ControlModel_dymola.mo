within FastBuildings.Battery.Optimization.models_dymola;
model ControlModel_dymola
    extends
    FastBuildings.Battery.Optimization.models_dymola.Partial_ControlModel_dymola(
                        E_max=1000*60*60*54,
                        P_max_d = 4*E_max/3.6e3,
                        P_max_c = E_max/3.6e3,
                        cost_battery_capacity_per_second = c_E_bat*E_max/3.6e6/(tau_E_shelf*seconds_year)/1.1);

    Real penalty_powDump
    "pay price for undesired power to the grid. (tso tariff)";

    Real cost(start=0, fixed=true) "Total objective, weighted ";
    Real cost_calc( start=0, fixed=true) "Total objective, weighted ";
equation
    der(cost)=1/3600000*(cEleFeedIn*powGrid + (cEle - cEleFeedIn)*powGridTakeOff) + penalty_powDump*powDump + cost_battery_capacity_per_second; //allow for different feed-in tariff.
    der(cost_calc)=1/3600000*(cEleFeedIn*powGrid + (cEle - cEleFeedIn)*powGridTakeOff) + cost_battery_capacity_per_second; //allow for different feed-in tariff.
    powGridTakeOff = max(powGrid, 0);
    penalty_powDump = (cEle - cEleFeedIn);
end ControlModel_dymola;
