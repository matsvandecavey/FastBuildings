within FastBuildings.Battery.Optimization;
partial model Sim_opt2
    extends Partial_sim2;
    Real powDump;
    Modelica.SIunits.Power powGrid = powEle - powPV + powBat + powDump;
    Modelica.SIunits.Power powGrid_orig = powEle - powPV;
end Sim_opt2;
