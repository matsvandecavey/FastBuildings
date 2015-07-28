within FastBuildings.Battery.Optimization;
model Sim2
    extends Partial_sim2;
    input Real powDump;
    Modelica.SIunits.Power powGrid = powEle - powPV + powBat + powDump;
    Modelica.SIunits.Power powGrid_orig = powEle - powPV;
end Sim2;
