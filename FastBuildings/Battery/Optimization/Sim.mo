within FastBuildings.Battery.Optimization;
partial model Sim
    extends Partial_sim;
    input Real powDump;
    Modelica.SIunits.Power powGrid = powEle - powPV + powBat + powDump;
    Modelica.SIunits.Power powGrid_orig = powEle - powPV;

end Sim;
