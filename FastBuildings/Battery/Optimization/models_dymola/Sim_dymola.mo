within FastBuildings.Battery.Optimization.models_dymola;
partial model Sim_dymola
    extends FastBuildings.Battery.Optimization.models_dymola.Partial_sim_dymola;
    Modelica.Blocks.Interfaces.RealInput powDump;
    Modelica.SIunits.Power powGrid;
    Modelica.SIunits.Power powGrid_orig;
equation
   powGrid = powEle - powPV + powBat + powDump;
   powGrid_orig = powEle - powPV;
end Sim_dymola;
