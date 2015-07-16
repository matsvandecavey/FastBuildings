within FastBuildings.Battery.Optimization;
model Sim
    extends Partial_sim;
    input Real powDump;
equation
  powGrid = powEle - powPV + powBat + powDump;
  powGrid_orig = powEle - powPV;
end Sim;
