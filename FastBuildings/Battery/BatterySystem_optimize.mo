within FastBuildings.Battery;
model BatterySystem_optimize
  "Use this model to extend from in an optimization."
  extends BatterySystem_c_d;

  Modelica.Blocks.Interfaces.RealInput P
    "disturbance input: Grid power demand from the loads" annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Real P_net "netto grid + battery power demand from the loads + battery";

equation
  P_net = P - PowerIn;
  annotation (Documentation(info="<html>
<p>The battery is used for power exchange with a grid with powerprofile P. </p>
<p>Optimize the Pcharge and Pdischarge (control inputs) to flatten the grid powerprofile. The sum equals the netto power &apos;PowerIn&apos; into the battery.</p>
<h4><span style=\"color:#008000\">Model use</span></h4>
<ul>
<li>Disturbance input P (grid power)</li>
<li>Battery power Pd and Pc can be optimized (using JModelica) to reach a certain objective given some constraints (min &LT; SoC, PIn &LT; max)</li>
<li>Also possible to use for simulation by specifying Pc and Pd. Better to use a <a href=\"FastBuildings.Battery.BatterySystemGeneral\">BatteryController</a> which makes sure the physical constraints are satisfied (logic implemented in <a href=\"FastBuildings.Battery.BatterySystemGeneral\">Ctrl</a>).</li>
</ul>
</html>"));
end BatterySystem_optimize;
