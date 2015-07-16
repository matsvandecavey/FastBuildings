within FastBuildings.Battery.Optimization;
model Partial_sim
    input Real powEle;
    input Real I_GloHor_sat;
    input Real cEle "Electricity cost, in Euro/kWh";
    input Real cEleFeedIn "Electricity cost, in Euro/kWh";

    Real powPV = 3*0.8*I_GloHor_sat*50 "Total pv production, always positive.";

    Modelica.SIunits.Power powBat;
    input Modelica.SIunits.Power powBat_d( start=powBat_dSta, fixed=false)
    "power from the grid towards the battery (before efficiency losses)";
    input Modelica.SIunits.Power powBat_c( start=powBat_cSta, fixed=false)
    "power from the battery towards the grid the battery (after efficiency losses)";
    Modelica.SIunits.Energy E_d(  start=0, fixed=true)
    "Energy on the grid, from the battery";
    Modelica.SIunits.Energy E_c(  start=0, fixed=true)
    "Energy off the grid, towards the battery";

    FastBuildings.Battery.Battery battery(
    E_max=E_max,
    DoD_max=DoD_max,
    eta_d=e_d,
    eta_c=e_c,
    SoCSta=SoCSta,
    eta_in=0.97,
    eta_out=0.97);
    Modelica.Blocks.Interfaces.RealOutput SoC "State of Charge of the battery";
    Modelica.SIunits.Energy E "energy level of the battery";
    parameter Modelica.SIunits.Energy E_max=1000*60*60*20;
    parameter Modelica.SIunits.Efficiency DoD_max=0.8;
    parameter Modelica.SIunits.Efficiency e_d=0.98;
    parameter Modelica.SIunits.Efficiency e_c=0.92
                                                 *0.95;
    parameter Modelica.SIunits.Efficiency SoCSta=0.5;
    parameter Real powBat_dSta=0;
    parameter Real powBat_cSta=10;

    Modelica.SIunits.Power powGrid;
    Modelica.SIunits.Power powGrid_orig;

equation
    powBat   = powBat_c - powBat_d;
    der(E_c) = powBat_c;
    der(E_d) = powBat_d;
    battery.powBat_c = powBat_c;
    battery.powBat_d = powBat_d;
    SoC = battery.SoC;
    E = battery.E;
end Partial_sim;
