within FastBuildings.Battery.Optimization.models_extra_states;
model Sim3
    extends FastBuildings.Battery.Optimization.models_extra_states.Partial_sim3;
    input Real powDump;
    Modelica.SIunits.Power powGrid = powEle - powPV + powBat + powDump;
    Modelica.Blocks.Interfaces.RealOutput powGrid_orig = powEle - powPV;
end Sim3;
