within FastBuildings.Battery.Optimization;
model Partial_sim2
   input Real powEle;
    input Real I_GloHor_sat;
    input Real cEle "Electricity cost, in Euro/kWh";
    input Real cEleFeedIn "Electricity cost, in Euro/kWh";

    Real powPV = 3*0.8*I_GloHor_sat*50 "Total pv production, always positive.";

    Modelica.SIunits.Power powBat;
    input Modelica.SIunits.Power powBat_d(start=powBat_dSta, fixed=false) = battery.powBat_d;
    input Modelica.SIunits.Power powBat_c(start=powBat_cSta, fixed=false) = battery.powBat_c;

    FastBuildings.Battery.Battery battery( E_max=E_max,
                        DoD_max=DoD_max,
                        eta_d=e_d,
                        eta_c=e_c,
                        SoCSta=SoCSta);
    Modelica.Blocks.Interfaces.RealOutput SoC=battery.SoC;
    Modelica.SIunits.Energy E = battery.E;
    parameter Modelica.SIunits.Energy E_max=60*60*20;
    parameter Modelica.SIunits.Efficiency DoD_max=0.8;
    parameter Modelica.SIunits.Efficiency e_d=0.98;
    parameter Modelica.SIunits.Efficiency e_c=0.92
                                                 *0.95;
    parameter Modelica.SIunits.Efficiency SoCSta=0.5;
    parameter Real powBat_dSta=0;
    parameter Real powBat_cSta=10;

equation
    powBat   = powBat_c - powBat_d;
end Partial_sim2;
