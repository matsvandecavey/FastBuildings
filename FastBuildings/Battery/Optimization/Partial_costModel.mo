within FastBuildings.Battery.Optimization;
partial model Partial_costModel "defines some variables used in all models"
  parameter Modelica.SIunits.Power P_max_d "E_max in Joule, P in W";
  parameter Modelica.SIunits.Power P_max_c "E_max in Joule, P in W";
  parameter Real tau_E_shelf = 10;
  parameter Real seconds_year=60*60*24*365;
  parameter Real c_E_bat = 350.0;
  parameter Real cost_battery_capacity_per_second;

  Real cost( start=0, fixed=true) "Total objective, weighted ";
  Real cost_tmp "Total objective, weighted ";
  Real cost_calc_tmp "Total objective, weighted ";
  Real cost_calc( start=0, fixed=true) "Total objective, weighted ";
equation

end Partial_costModel;
