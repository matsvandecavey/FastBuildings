within FastBuildings.Battery.Optimization;
model ControlModel_dymola
    extends FastBuildings.Battery.Optimization.Partial_ControlModel_dymola(
                        E_max=1000*60*60*54,
                        P_max_d = 4*E_max/3.6e3,
                        P_max_c = E_max/3.6e3,
                        cost_battery_capacity_per_second = c_E_bat*E_max/3.6e6/(tau_E_shelf*seconds_year)/1.1);

    Real penalty_powDump = (cEle - cEleFeedIn)
    "pay price for undesired power to the grid. (tso tariff)";

equation
    der(cost)=1/3600000*(cEleFeedIn*powGrid + (cEle - cEleFeedIn)*powGridTakeOff) + penalty_powDump*powDump + cost_battery_capacity_per_second; //allow for different feed-in tariff.
    der(cost_calc)=1/3600000*(cEleFeedIn*powGrid + (cEle - cEleFeedIn)*powGridTakeOff) + cost_battery_capacity_per_second; //allow for different feed-in tariff.
    powGridTakeOff = max(powGrid, 0);
end ControlModel_dymola;
