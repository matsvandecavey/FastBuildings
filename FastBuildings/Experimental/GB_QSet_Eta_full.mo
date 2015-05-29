within FastBuildings.Experimental;
model GB_QSet_Eta_full
  "Gas boiler with  QSet end eta as function of TAmb, TSup and PFue"
  extends Partial_HeatProduction;
  outer Input.BaseClasses.Partial_SIM simFasBui
    "Weather and input data, to be provided by an inner submodel of Partial_SIM"
                                                                                                        annotation(Placement(visible = true, transformation(origin={-90.1538,
            89.5214},                                                                                                    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput PEle
    annotation (Placement(transformation(extent={{96,30},{116,50}})));
  Modelica.Blocks.Interfaces.RealOutput PFuel
    annotation (Placement(transformation(extent={{96,-50},{116,-30}})));

  /*
  The equation for eta is a GLM found by OLS regression with statsmodels.
  To obtain a generic model, a backward selection is performed based on a full
  factorial model with TAmb, TSup and Q as predictors.
  
  The predictors are shifted so the intercept is a realistic value for these 
  conditions: 
  - full load
  - Temperature regime of 7/35 (same as heat pump, note very relevant for boiler 
  (but it does not really matter)
  
  The parameters can (and some will) be zero. 
  */

  parameter Real Intercept = 0 annotation(Evaluate=false);
  parameter Real TAmb7 = 0 annotation(Evaluate=false);
  parameter Real TSup35 = 0 annotation(Evaluate=false);
  parameter Real Q86000 = 0 annotation(Evaluate=false);
  parameter Real TAmb7_TSup35 = 0 annotation(Evaluate=false);
  parameter Real TAmb7_Q86000 = 0 annotation(Evaluate=false);
  parameter Real TSup35_Q86000 = 0 annotation(Evaluate=false);
  parameter Real TAmb7_TSup35_Q86000 = 0 annotation(Evaluate=false);

  Real TAmb_7 = simFasBui.TAmb-(7+273.15);
  Real TSup_35 = heaPorHot.T-(35+273.15);
  Real Q_86000 = QSet - 86000;

  Real eta =  Intercept +
              TAmb7 * TAmb_7 +
              TSup35 * TSup_35 +
              Q86000 * Q_86000 +
              TAmb7_TSup35 * (TAmb_7 * TSup_35) +
              TAmb7_Q86000 * (TAmb_7 * Q_86000) +
              TSup35_Q86000 * (TSup_35 * Q_86000) +
              TAmb7_TSup35_Q86000 * (TAmb_7 * TSup_35 * Q_86000);
  Modelica.Blocks.Interfaces.RealInput QSet
    annotation (Placement(transformation(extent={{-126,40},{-86,80}})));
equation
  PEle = 0;
  PFuel = QSet/eta;

  connect(QSet, preQ.Q_flow) annotation (Line(
      points={{-106,60},{-20,60},{-20,0},{-40,0}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end GB_QSet_Eta_full;
