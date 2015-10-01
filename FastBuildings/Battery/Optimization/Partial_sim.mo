within FastBuildings.Battery.Optimization;
model Partial_sim
    input Real powEle;
    input Real I_GloHor_sat;
    input Real cEle "Electricity cost, in Euro/kWh";
    input Real cEleFeedIn "Electricity cost, in Euro/kWh";

    parameter Real powPV_nom = 3*50 "kW";
    Real powPV = powPV_nom*0.8*I_GloHor_sat
    "Total pv production, always positive.";

    Modelica.SIunits.Power powBat = powBat_c - powBat_d;
    input Modelica.SIunits.Power powBat_d( start=powBat_dSta, fixed=false) = battery.powBat_d
    "power from the grid towards the battery (before efficiency losses)";
    input Modelica.SIunits.Power powBat_c( start=powBat_cSta, fixed=false) = battery.powBat_c
    "power from the battery towards the grid the battery (after efficiency losses)";

    FastBuildings.Battery.Battery battery(
    E_max=E_max,
    DoD_max=DoD_max,
    eta_d=e_d,
    eta_c=e_c,
    SoCSta=SoCSta,
    eta_in=0.97,
    eta_out=0.97);
    Modelica.Blocks.Interfaces.RealOutput SoC = battery.SoC
    "State of Charge of the battery";
    Modelica.SIunits.Energy E =  battery.E "energy level of the battery";
    parameter Modelica.SIunits.Energy E_max = 1000*60*60*2000;
    parameter Modelica.SIunits.Efficiency DoD_max=0.8;
    parameter Modelica.SIunits.Efficiency e_d=0.98;
    parameter Modelica.SIunits.Efficiency e_c=0.92
                                                 *0.95;
    parameter Modelica.SIunits.Efficiency SoCSta=0.5;
    parameter Real powBat_dSta=0;
    parameter Real powBat_cSta=10;

end Partial_sim;