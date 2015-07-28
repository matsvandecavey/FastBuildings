within FastBuildings.Battery.Optimization;
partial model Sim_opt3
    extends Partial_sim3;
    Real powDump;
    Modelica.SIunits.Power powGrid = powEle - powPV + powBat + powDump;
    Modelica.Blocks.Interfaces.RealOutput powGrid_orig = powEle - powPV;
end Sim_opt3;
