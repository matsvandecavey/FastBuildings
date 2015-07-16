within FastBuildings.Experimental;
model PV_system "most simple model of PV production"
  parameter Modelica.SIunits.Power P_installed = 1289
    "installed peak power in kWp (= aantal panelen)";
  parameter Real PR = 0.8;
  parameter Real efficiency = 0.2;

  Modelica.Blocks.Interfaces.RealOutput P "Output power"
    annotation (Placement(transformation(extent={{100,-8},{120,12}})));
  outer Input.BaseClasses.Partial_SIM               simFasBui
    "Weather data, to be provided by an inner submodel of Partial_SIM"                                                     annotation(Placement(visible = true, transformation(origin={-86.1538,
            81.5214},                                                                                                    extent = {{-10,-10},{10,10}}, rotation = 0)));
equation
  P = P_installed*PR*efficiency*simFasBui.irr[1];
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Polygon(
          points={{-100,100},{-20,0},{-100,-100},{-100,100}},
          lineColor={0,0,255},
          smooth=Smooth.None),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,255}),
        Text(
          extent={{-54,122},{64,22}},
          lineColor={0,0,255},
          textString="%name")}));
end PV_system;
