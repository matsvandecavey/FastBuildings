within FastBuildings.Battery.Optimization;
partial model Sim_opt_min
    extends Partial_sim(
              powBat_c(min=0),
              powBat_d(min=0),
              E(min=0));
    Real powDump(start=0);
    Modelica.SIunits.Power powGrid = powEle - powPV + powBat + powDump;
    Modelica.SIunits.Power powGrid_orig = powEle - powPV;
end Sim_opt_min;
