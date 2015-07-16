within FastBuildings.Battery;
model BatterySystem_c_d
  "Battery system with charge and discharge profile as input"
  extends partial_BatterySystem;
  Real E=battery.E "Energy level of the battery";
  Modelica.Blocks.Interfaces.RealInput Pd
    "control input: Dischargeing power, bring input to toplevel for optimization"
                                                                                  annotation (Placement(transformation(extent={{-120,-70},{-80,-30}})));
  Modelica.Blocks.Interfaces.RealInput Pc
    "control input: Chargeing power, bring input to toplevel for optimization" annotation (Placement(transformation(extent={{-120,30},{-80,70}})));
  Real PowerIn "Power to the battery (charge (Pc) > 0, discharge (-Pd) <0";

equation
  PowerIn = Pc - Pd;
  Pc=battery.Pc;
  Pd=battery.Pd;

  annotation (Documentation(info="<html>
<p>BatterySystem that simulates the battery for a ginven Pcharge and Pdischarge power input and a given <a href=\"FastBuildings.Battery.Interfaces.BatteryType\">technology</a>.</p>
</html>"));
end BatterySystem_c_d;
