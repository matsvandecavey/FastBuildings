within FastBuildings.Battery.Optimization;
model Sim3
    extends Partial_sim3;
    input Real powDump;
    Modelica.SIunits.Power powGrid = powEle - powPV + powBat + powDump;
    Modelica.Blocks.Interfaces.RealOutput powGrid_orig = powEle - powPV;
end Sim3;
