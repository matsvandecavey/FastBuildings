within FastBuildings.Battery.Optimization.models_dymola;
model Partial_ControlModel_opt_dymola
  "defines some variables used in all models"
  extends FastBuildings.Battery.Optimization.models_dymola.Sim_opt_dymola( E_max = 3.6e6*150);
  parameter Modelica.SIunits.Power P_max_d = E_max/2 "E_max in Joule, P in W";
  parameter Modelica.SIunits.Power P_max_c = E_max/2 "E_max in Joule, P in W";
  parameter Real tau_E_shelf = 10;
  parameter Real seconds_year=60*60*24*365;
  parameter Real c_E_bat = 350.0;
  parameter Real cost_battery_capacity_per_second= c_E_bat*E_max/3.6e6/(tau_E_shelf*seconds_year)
    "price (euro) per second for battery capacity calculated for 10y use.";

  input Real powGridTakeOff
    "Positive part of electricity exchange with the grid";

  //Calculated cost
//  Real cost( start=0, fixed=true) "Total objective, weighted ";
  //Real cost_calc( start=0, fixed=true) "Total objective, weighted ";
  //Profile constraints
  parameter Real powPV_max( min=0, max = 2000*0.8*1000)= 1*0.8*1000
    "max controlled power out of PV system";
  parameter Real ramp_duration = 2*3600;
  parameter Real start_increase( min = 3600*6, max=3600*10) = 3600*8;
  parameter Real stop_increase = start_increase + ramp_duration;
  parameter Real start_decrease( min = 3600*14, max=3600*20) = 3600*18;
  parameter Real stop_decrease = start_decrease + ramp_duration;

equation
    if time <= start_increase then
        powGrid =0;
    elseif time >= start_increase and  time <= stop_increase then
        powGrid =-(-powPV_max*(start_increase/ramp_duration) + (powPV_max/ramp_duration)*time);
    elseif time >= stop_increase and  time <= start_decrease then
        powGrid = -(powPV_max);
    elseif time >= start_decrease  and  time <= stop_decrease then
        powGrid = -(-powPV_max*((24*3600-stop_decrease)/ramp_duration) + (powPV_max/ramp_duration)*(24*3600 - time));
    else
        powGrid = 0;
    end if;
  annotation (Documentation(info="<html>
<p>This is how the dymola model of our optimization model would look</p>
</html>"));
end Partial_ControlModel_opt_dymola;
