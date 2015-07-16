within FastBuildings.Battery;
model BatterySystemGeneral
  extends FastBuildings.Battery.partial_BatterySystem(redeclare Data.LiIon
      technology);

  // Models
  BatteryCtrlGeneral2 batteryCtrlGeneral2(
    numPha=numPha,
    DoD_max=DoD_max,
    E_max=E_max,
    eta_out=technology.eta_out,
    eta_in=technology.eta_in,
    eta_c=technology.eta_c,
    eta_d=technology.eta_d,
    e_c=technology.e_c,
    e_d=technology.e_d) annotation (Placement(transformation(extent={{-2,-10},{18,10}})));

  // Individual parameters
  parameter Integer numPha=1;

  Modelica.Blocks.Interfaces.RealInput P(final quantity="Power", final unit="W")
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));

equation
  connect(batteryCtrlGeneral2.SoC, battery.SoC)
    annotation (Line(
      points={{18,0},{60,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(batteryCtrlGeneral2.P, P) annotation (Line(
      points={{-2,0},{-100,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(batteryCtrlGeneral2.PBat_charge, battery.Pc)
    annotation (Line(
      points={{20,5},{62,5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(batteryCtrlGeneral2.PBat_discharge, battery.Pd) annotation (Line(
      points={{20,-5},{62,-5}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics), Documentation(info="<html>
<p>Simulate a battery system considering the physical limits of a battery</p>
<h4><span style=\"color:#008000\">model use</span></h4>
<ul>
<li>specify a desired power profile to the battery</li>
</ul>
<p><br><h4><span style=\"color:#008000\">example</span></h4></p>
<p><br>Run <a href=\"FastBuildings.Battery.Examples.Run_bat\">example</a> to check the controller and battery</p>
</html>"));
end BatterySystemGeneral;
