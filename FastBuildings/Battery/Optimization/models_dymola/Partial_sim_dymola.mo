within FastBuildings.Battery.Optimization.models_dymola;
model Partial_sim_dymola

  Modelica.Blocks.Interfaces.RealInput powEle( final quantity="Power", final unit="W") annotation (Placement(transformation(extent={{-20,-20},
          {20,20}},
      rotation=270,
      origin={30,100})));
  Modelica.Blocks.Interfaces.RealInput I_GloHor_sat annotation (Placement(transformation(extent={{-20,-20},
          {20,20}},
      rotation=270,
      origin={-30,100})));
  Modelica.Blocks.Interfaces.RealInput cEle "Electricity cost, in Euro/kWh" annotation (Placement(transformation(extent={{-20,-20},
          {20,20}},
      rotation=180,
      origin={100,10})));
  Modelica.Blocks.Interfaces.RealInput cEleFeedIn
    "Electricity cost, in Euro/kWh"
                                  annotation (Placement(transformation(extent={{-20,-20},
          {20,20}},
      rotation=180,
      origin={100,-10})));

  parameter Real powPV_nom = 3*50 "kW";
  Real powPV "Total pv production, always positive.";

  Modelica.SIunits.Power powBat;
  Modelica.Blocks.Interfaces.RealInput powBat_d(start=powBat_dSta, fixed=false, final quantity="Power", final unit="W")
    "power from the grid towards the battery (before efficiency losses)"
                                                                       annotation (Placement(transformation(extent={{-118,18},
          {-78,58}})));
  Modelica.Blocks.Interfaces.RealInput powBat_c( start=powBat_cSta, fixed=false, final quantity="Power", final unit="W")
    "power from the battery towards the grid the battery (after efficiency losses)"
                                                                                  annotation (Placement(transformation(extent={{-120,
          -50},{-80,-10}})));

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
  parameter Modelica.SIunits.Energy E_max = 1000*60*60*2000;
  parameter Modelica.SIunits.Efficiency DoD_max=0.8;
  parameter Modelica.SIunits.Efficiency e_d=0.98;
  parameter Modelica.SIunits.Efficiency e_c=0.92
                                               *0.95;
  parameter Modelica.SIunits.Efficiency SoCSta=0.5;
  parameter Real powBat_dSta=0;
  parameter Real powBat_cSta=10;

equation
  powPV = powPV_nom*0.8*I_GloHor_sat;
  powBat = powBat_c - powBat_d;
  powBat_c= battery.powBat_c;
  powBat_d= battery.powBat_d;
  SoC = battery.SoC;
  E =  battery.E;
annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
          -100},{100,100}})), Documentation(info="<html>
<p>This is how a Dymola version of the model would look like:</p>
<ul>
<li>icons for the inputs</li>
<li>all equations in the equation section</li>
</ul>
</html>"));
end Partial_sim_dymola;
