within FastBuildings.Battery;
model Battery
  extends Modelica.Blocks.Interfaces.BlockIcon;

  // Inputs and outputs
  Modelica.SIunits.Power powBat_d_net;
  Modelica.SIunits.Power powBat_c_net;

  Modelica.Blocks.Interfaces.RealInput powBat_d(final quantity="Power", final unit="W") annotation (Placement(transformation(extent={{-120,-70},{-80,-30}})));
  Modelica.Blocks.Interfaces.RealInput powBat_c(final quantity="Power", final unit="W") annotation (Placement(transformation(extent={{-120,30},{-80,70}})));
  Modelica.Blocks.Interfaces.RealOutput SoC(start=SoCSta, fixed=true)
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={-120,0})));
  parameter Modelica.SIunits.Energy E_max=54*3.6e6;

  parameter Modelica.SIunits.Efficiency eta_out=1;
  parameter Modelica.SIunits.Efficiency eta_in=1;
  parameter Modelica.SIunits.Efficiency eta_d=1;
  parameter Modelica.SIunits.Efficiency eta_c=1;
  parameter Modelica.SIunits.Frequency delta_sd=0.001/24/60/60;
  parameter Modelica.SIunits.Efficiency SoCSta=0.5;
  parameter Modelica.SIunits.Efficiency DoD_max=0.80
    "Maximum discharge [%/100]";
  parameter Modelica.SIunits.Energy E_min = (1-DoD_max)  *E_max;

  Modelica.SIunits.Energy E;

equation
  SoC = E/E_max;
  powBat_d_net = powBat_d/eta_d/eta_out;
  powBat_c_net = powBat_c*eta_c*eta_in;
  der(E) = powBat_c_net - powBat_d_net - delta_sd*E_max "
  parameter Modelica.SIunits.Power P_max_d;
  parameter Modelica.SIunits.Power P_max_c;
  PowerIn = Pc -  Pd;
  P_net=P-PowerIn 
  constraint
  E >= E_max*DoD_max;
  E <= E_max;
  -Pd>=-P_max;
  Pd<=P_max;
  Pc>=0;
  Pd>=0;
  Pd*Pc<=0;
  Pd*Pc>=-0;
";
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics),
      Documentation(info="<html>
<p>Battery model to evaluate State of Charge: SoC based on power to the battery: Pc(harge) and power from the battery Pd(ischarge).</p>
<h4><span style=\"color:#008000\">Model use</span></h4>
<ul>
<li>Specify input variables Pc and Pd.</li>
<li>specify battery specific parameters (use <a href=\"FastBuildings.Battery.BatterySystem_c_d\">batterySystem</a> to simulate with parameters from a given <a href=\"FastBuildings.Battery.Interfaces.BatteryType\">technology</a>)</li>
</ul>
</html>"));
end Battery;
