within FastBuildings.Battery;
partial model partial_BatterySystem
  // Will be further 'extended' for a battery storage system and EV

  replaceable parameter FastBuildings.Battery.Interfaces.BatteryType technology
    "Choose a battery type" annotation (choicesAllMatching=true);

  // Individual parameters
  parameter Modelica.SIunits.Energy E_max=1 "Total battery capacity in [kW.h]";
  parameter Modelica.SIunits.Efficiency SoC_start=0.2
    "How full is the battery at the start? [%/100]";
  parameter Modelica.SIunits.Efficiency DoD_max=0.80
    "Maximum discharge [%/100]";

  FastBuildings.Battery.Battery battery(
    SoC_start=SoC_start,
    E_max=E_max,
    DoD_max=DoD_max,
    delta_sd=technology.delta_sd,
    eta_out=technology.eta_out,
    eta_in=technology.eta_in,
    eta_c=technology.eta_c,
    eta_d=technology.eta_d)
    annotation (Placement(transformation(extent={{62,-10},{82,10}})));

  annotation (Icon, Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics),
    Documentation(info="<html>
<p>Partial batterySystem layout allows using records for batteryparameters.</p>
</html>"));
end partial_BatterySystem;
