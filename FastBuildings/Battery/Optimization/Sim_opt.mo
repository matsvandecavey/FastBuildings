within FastBuildings.Battery.Optimization;
partial model Sim_opt
    extends Partial_sim;
    Real powDump( start=0);
    Modelica.SIunits.Power powGrid = powEle - powPV + powBat + powDump;
    Modelica.SIunits.Power powGrid_orig = powEle - powPV;
end Sim_opt;
