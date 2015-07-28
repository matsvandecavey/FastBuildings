within FastBuildings.Battery.Optimization;
partial model Sim_dymola
    extends Partial_sim_dymola;
    input Real powDump;
    Modelica.SIunits.Power powGrid;
    Modelica.SIunits.Power powGrid_orig;
equation
   powGrid = powEle - powPV + powBat + powDump;
   powGrid_orig = powEle - powPV;
end Sim_dymola;
