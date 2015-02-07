within FastBuildings.Experimental;
model HVAC_KK_TZon
  "Total HVAC model for KK, with TZon instead of TAmb for connection to capTecRoo"
  extends HVAC.Partial_HVAC;
  parameter Real fraRad = 0.3 "Fraction of heating to radiation";
  parameter SI.ThermalResistance rLos = 1
    "Total thermal resistance to the technical room, in K/W";
  parameter SI.HeatCapacity cHea = 1 "Thermal capacity of the zone";
  parameter SI.ThermalResistance rTecRoo = 1
    "Total thermal resistance to the technical room, in K/W";
  parameter SI.HeatCapacity cTecRoo = 1 "Thermal capacity of the zone";

  GB_QSet_ConstantEta gb
    annotation (Placement(transformation(extent={{72,30},{92,50}})));
  HP_AW_QSet_ConstantCOP hp1
    annotation (Placement(transformation(extent={{72,-10},{92,10}})));
  HP_AW_QSet_ConstantCOP hp2
    annotation (Placement(transformation(extent={{72,-50},{92,-30}})));
  Zones.BaseClasses.Capacitor capHea(c=cHea)
    annotation (Placement(transformation(extent={{30,60},{50,80}})));
  TwoPort_PrescribedHeatFlow qCon annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-70,0})));
  TwoPort_PrescribedHeatFlow qRad annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-70,-40})));
  Modelica.Blocks.Sources.RealExpression expQCon(y=(1 - fraRad)*simFasBui.qHeaCoo)
    annotation (Placement(transformation(extent={{0,10},{-60,30}})));
  Modelica.Blocks.Sources.RealExpression expQRad(y=fraRad*simFasBui.qHeaCoo)
    annotation (Placement(transformation(extent={{0,-30},{-60,-10}})));
  HT.Sources.FixedHeatFlow      qEmb(Q_flow=0)
    annotation (Placement(transformation(extent={{-68,30},{-84,46}})));
  HT.Sources.PrescribedTemperature
                              preTAmb "Ambient temperature"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-48,60})));
  Zones.BaseClasses.Resistance
             resLos(r=rLos) "Resistance for heat losses to technical room"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={12,60})));
  Zones.BaseClasses.Capacitor capTecRoo(c=cTecRoo)
    annotation (Placement(transformation(extent={{-16,56},{4,36}})));
  Zones.BaseClasses.Resistance resTecRoo(r=rTecRoo)
    "Resistance for heat losses to technical room" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-24,60})));
equation
  connect(heaPorCon, qCon.heaPor_b) annotation (Line(
      points={{-99.83,0.0682},{-90,0.0682},{-90,0},{-80,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heaPorRad, qRad.heaPor_b) annotation (Line(
      points={{-100.17,-40},{-80,-40}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(qCon.heaPor_a, capHea.heaPor) annotation (Line(
      points={{-60,0},{40,0},{40,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(qRad.heaPor_a, capHea.heaPor) annotation (Line(
      points={{-60,-40},{40,-40},{40,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(expQCon.y, qCon.QSet) annotation (Line(
      points={{-63,20},{-70,20},{-70,10.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(expQRad.y, qRad.QSet) annotation (Line(
      points={{-63,-20},{-70,-20},{-70,-29.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heaPorEmb, qEmb.port) annotation (Line(
      points={{-100.614,40.944},{-90,40.944},{-90,38},{-84,38}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(resLos.heaPor_a, capHea.heaPor) annotation (Line(
      points={{22,60},{40,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(resLos.heaPor_b, resTecRoo.heaPor_a) annotation (Line(
      points={{2,60},{-14,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(resLos.heaPor_b, capTecRoo.heaPor) annotation (Line(
      points={{2,60},{-6,60},{-6,56}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(resTecRoo.heaPor_b, preTAmb.port) annotation (Line(
      points={{-34,60},{-42,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(hp1.heaPorHot, capHea.heaPor) annotation (Line(
      points={{72.017,0.00682},{40,0.00682},{40,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(hp2.heaPorHot, capHea.heaPor) annotation (Line(
      points={{72.017,-39.9932},{40,-39.9932},{40,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(gb.heaPorHot, capHea.heaPor) annotation (Line(
      points={{72.017,40.0068},{40,40.0068},{40,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(TZon, preTAmb.T) annotation (Line(
      points={{-99.578,-80.3407},{-44,-80.3407},{-44,46},{-66,46},{-66,60},{
          -55.2,60}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics), Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                                                    graphics));
end HVAC_KK_TZon;
