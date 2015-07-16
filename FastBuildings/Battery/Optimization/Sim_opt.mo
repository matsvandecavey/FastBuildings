within FastBuildings.Battery.Optimization;
partial model Sim_opt
    extends Partial_sim;
    Real powDump;
equation
  powGrid  = powEle - powPV + powBat + powDump;
  powGrid_orig = powEle - powPV;
end Sim_opt;
